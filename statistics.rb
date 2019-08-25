require 'csv'
require 'json'

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

class StatisticsFormatter
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def print_statistcs
    puts "DISTRIBUTION OF THE NUMBER OF FELLOW PASSENGERS PER USER:\t #{distribution_of_the_number_of_fellow_passenger_per_user}"
    puts "THE AVERAGE COMPENSATION PER PASSENGER:\t\t\t\t #{the_average_compensation_per_passenger}"
    puts "THE MOST POPULAR AIRLINE CHOSEN BY PASSENGERS:\t\t\t #{the_most_popular_airline_chosen_by_passengers}"
    puts "THE PERCENTAGE OF USERS WHO GOT COMPENSATION:\t\t\t #{the_percentage_of_users_who_got_compensation} %"
  end

  private

  def count_of_all
    data.count
  end

  def distribution_of_the_number_of_fellow_passenger_per_user
    all_of_fellow_passenger = 0
    data.each {|i| all_of_fellow_passenger += i["number_of_fellow_passenger"].to_i}
    result = all_of_fellow_passenger / count_of_all
    result
  end

  def the_average_compensation_per_passenger
    sum_of_compensation = 0
    data.each {|i| sum_of_compensation += i["total_compensation_amount"].to_f}
    result_of_average = sum_of_compensation / count_of_all
    result_of_average.round(2)
  end

  def the_most_popular_airline_chosen_by_passengers
    most_popular_airline = {}
    data.each do |i|
      most_popular_airline[i["airline_code"]] ||= 0
      most_popular_airline[i["airline_code"]] += 1
    end
    most_popular_airline.sort_by{|k,v| v}
    most_popular_airline.first[0]
  end

  def the_percentage_of_users_who_got_compensation
    count_of_got_compensation = 0.0
    data.each {|i| count_of_got_compensation += 1 if i["did_receive_compensation"].to_s == 'true'}
    result = (count_of_got_compensation / count_of_all)*100
    result.round(2)
  end
end

StatisticsApp.new(ARGV[0]).run
