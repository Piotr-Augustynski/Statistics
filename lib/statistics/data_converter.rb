class DataConverter
  attr_reader :extension, :data
  SUPPORTED_FILE_TYPE = ['JSON', 'CSV']

  def initialize(data, extension)
    @data = data
    @extension = extension
  end

  def call
    if file_supported?(extension)
      convert(data)
    else
      puts "Unsupported file format!\nTry with CSV or JSON file"
      exit
    end
  end

  private

  def convert(data)
    case extension
    when 'JSON' then json_parser(data)
    when 'CSV' then csv_parser(data)
    end
  end

  def file_supported?(type)
    SUPPORTED_FILE_TYPE.include?(type)
  end

  def json_parser(json)
    JSON.parse(json)
  end

  def csv_parser(csv)
    CSV.parse(csv, headers: true).map(&:to_h)
  end
end
