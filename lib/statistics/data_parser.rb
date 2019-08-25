class DataParser
  attr_reader :extension, :data

  def initialize(data, extension)
    @data = data
    @extension = extension
  end

  def call
    case extension
    when 'JSON'
      json_parser(data)
    when 'CSV'
      csv_parser(data)
    end
  end

  private

  def json_parser(json)
    JSON.parse(json)
  end

  def csv_parser(csv)
    CSV.parse(csv, headers: true).map(&:to_h)
  end
end
