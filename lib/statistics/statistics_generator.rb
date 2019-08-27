# frozen_string_literal: true

class StatisticsGenerator
  attr_reader :content

  def initialize(content)
    @content = content
  end

  def call
    { 
      distribution_of_the_number_of_fellow_passenger_per_user: distribution_of_the_number_of_fellow_passenger_per_user,
      the_average_compensation_per_passenger: the_average_compensation_per_passenger,
      the_most_popular_airline_chosen_by_passengers: the_most_popular_airline_chosen_by_passengers,
      the_percentage_of_users_who_got_compensation: the_percentage_of_users_who_got_compensation
    }
  end

  private

  def count_of_all
    content.count
  end

  def distribution_of_the_number_of_fellow_passenger_per_user
    all_of_fellow_passenger = 0
    content.each { |i| all_of_fellow_passenger += i['number_of_fellow_passenger'].to_i }
    result = all_of_fellow_passenger / count_of_all
    result
  end

  def the_average_compensation_per_passenger
    sum_of_compensation = 0
    content.each { |i| sum_of_compensation += i['total_compensation_amount'].to_f }
    result_of_average = sum_of_compensation / count_of_all
    result_of_average.round(2)
  end

  def the_most_popular_airline_chosen_by_passengers
    most_popular_airline = {}
    content.each do |i|
      most_popular_airline[i['airline_code']] ||= 0
      most_popular_airline[i['airline_code']] += 1
    end
    most_popular_airline.sort_by { |_k, v| v }
    most_popular_airline.first[0]
  end

  def the_percentage_of_users_who_got_compensation
    count_of_got_compensation = 0.0
    content.each { |i| count_of_got_compensation += 1 if i['did_receive_compensation'].to_s == 'true' }
    result = (count_of_got_compensation / count_of_all) * 100
    result.round(2)
  end
end
