# frozen_string_literal: true

class DataConverter
  attr_reader :data, :extension
  SUPPORTED_FILE_TYPE = %w[json csv].freeze

  def initialize(data, extension)
    @data = data
    @extension = extension
  end

  def call
    convert
  end

  def self.supported_file?(file_extension)
    SUPPORTED_FILE_TYPE.include?(file_extension)
  end

  private

  def convert
    case extension
    when 'json' then json_parser
    when 'csv' then csv_parser
    end
  end

  def json_parser
    JSON.parse(data)
  end

  def csv_parser
    CSV.parse(data, headers: :first_row).map(&:to_h)
  end
end
