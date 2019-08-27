# frozen_string_literal: true

class DataLoader
  attr_reader :file_path

  def initialize(file_path)
    @file_path = file_path
  end

  def call
    file_extension = generate_file_extension
    if DataConverter.supported_file?(file_extension)
      [read_file, file_extension]
    else
      puts "Unsupported file format!\nTry with CSV or JSON file"
      exit
    end
  end

  private

  def generate_file_extension
    extension = File.extname(file_path)
    extension.delete('.').downcase
  end

  def read_file
    File.read(file_path)
  end
end
