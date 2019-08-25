class DataLoader
  attr_reader :file

  def initialize(file)
    @file = file
  end

  def call
    data = set_data
    file_extension = set_file_extension
    parsed_data = DataParser.new(data, file_extension).call
    parsed_data
  end

  private

  def set_file_extension
    extension = File.extname(file)
    extension.delete('.').upcase
  end

  def set_data
    File.read(file)
  end
end
