# frozen_string_literal: true

class StatisticsApp
  attr_reader :file_path

  def initialize(file_path)
    @file_path = file_path
  end

  def run
    data, extension = DataLoader.new(file_path).call
    converted_data = DataConverter.new(data, extension).call
    StatisticsFormatter.new(converted_data).generate_statistcs
  end
end
