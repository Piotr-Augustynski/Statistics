# frozen_string_literal: true

class StatisticsApp
  attr_reader :file_path

  def initialize(file_path)
    @file_path = file_path
  end

  def run
    data, extension = load_data
    converted_data = convert_data(data, extension)
    generate_statistics(converted_data)
  end

  private

  def load_data
    DataLoader.new(file_path).call
  end

  def convert_data(data, extension)
    DataConverter.new(data, extension).call
  end

  def generate_statistics(data)
    StatisticsGenerator.new(data).call
  end
end
