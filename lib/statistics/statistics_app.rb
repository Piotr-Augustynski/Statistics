# frozen_string_literal: true

class StatisticsApp
  attr_reader :file_path

  def initialize(file_path)
    @file_path = file_path
  end

  def run
    data, extension = DataLoader.new(file_path).call
    converted_data = DataConverter.new(data, extension).call
    StatisticsGenerator.new(converted_data).call
  end
end
