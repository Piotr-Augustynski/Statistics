# frozen_string_literal: true

class DataLoader
  attr_reader :file

  def initialize(file)
    @file = file
  end

  def call
    data = read_data
    file_extension = set_file_extension
    converted_data = DataConverter.new(data, file_extension).call
    converted_data
  end

  private

  def set_file_extension
    extension = File.extname(file)
    extension.delete('.').upcase
  end

  def read_data
    File.read(file)
  end
end
