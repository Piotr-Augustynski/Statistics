# frozen_string_literal: true

class StatisticsApp
  attr_reader :file

  def initialize(file)
    @file = file
  end

  def run
    data = DataLoader.new(file).call
    statistics = StatisticsFormatter.new(data).print_statistcs
    statistics
  end
end
