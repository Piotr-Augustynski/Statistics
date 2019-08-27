# frozen_string_literal: true

require_relative 'spec_helper'

describe StatisticsFormatter do
  json_path = '/Users/Wicek/programming/statistics/spec/files/data.json'
  csv_path = '/Users/Wicek/programming/statistics/spec/files/data.csv'
  json_data = DataConverter.new(DataLoader.new(json_path).call.first, 'json').call
  csv_data = DataConverter.new(DataLoader.new(csv_path).call.first, 'csv').call

  describe '#generate_statistics' do
    json_results = StatisticsFormatter.new(json_data).generate_statistcs
    csv_results = StatisticsFormatter.new(csv_data).generate_statistcs

    it 'return Hash' do
      expect(json_results.class).to eq(Hash)
      expect(csv_results.class).to eq(Hash)
    end

    it 'always return four elements' do
      expect(json_results.count).to eq(4)
      expect(csv_results.count).to eq(4)
    end    

    it 'return keys of the symbol type' do
      expect(json_results.keys.first.class).to eq(Symbol)
      expect(csv_results.keys.first.class).to eq(Symbol)
    end

    it 'return valus of the correct types' do
      expect(json_results[:distribution_of_the_number_of_fellow_passenger_per_user].class).to eq(Integer)
      expect(json_results[:the_average_compensation_per_passenger].class).to eq(Float)
      expect(json_results[:the_most_popular_airline_chosen_by_passengers].class).to eq(String)
      expect(json_results[:the_percentage_of_users_who_got_compensation].class).to eq(Float)
      expect(csv_results[:distribution_of_the_number_of_fellow_passenger_per_user].class).to eq(Integer)
      expect(csv_results[:the_average_compensation_per_passenger].class).to eq(Float)
      expect(csv_results[:the_most_popular_airline_chosen_by_passengers].class).to eq(String)
      expect(csv_results[:the_percentage_of_users_who_got_compensation].class).to eq(Float)
    end
  end
end
