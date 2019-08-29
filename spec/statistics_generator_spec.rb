# frozen_string_literal: true

require_relative 'spec_helper'

describe StatisticsGenerator do
  let(:json) do
    json_path = File.join(File.dirname(__FILE__), 'files', 'data.json')
    json_data = DataConverter.new(DataLoader.new(json_path).call.first, 'json').call
    StatisticsGenerator.new(json_data).call
  end
  let(:csv) do
    csv_path = File.join(File.dirname(__FILE__), 'files', 'data.csv')
    csv_data = DataConverter.new(DataLoader.new(csv_path).call.first, 'csv').call
    StatisticsGenerator.new(csv_data).call
  end

  describe '#call' do
    it 'return Hash' do
      expect(json.class).to eq(Hash)
      expect(csv.class).to eq(Hash)
    end

    it 'always return four elements' do
      expect(json.count).to eq(4)
      expect(csv.count).to eq(4)
    end

    it 'return keys of the symbol type' do
      expect(json.keys.first.class).to eq(Symbol)
      expect(csv.keys.first.class).to eq(Symbol)
    end

    it 'return valus of the correct types' do
      expect(json[:distribution_of_the_number_of_fellow_passenger_per_user].class).to eq(Integer)
      expect(json[:the_average_compensation_per_passenger].class).to eq(Float)
      expect(json[:the_most_popular_airline_chosen_by_passengers].class).to eq(String)
      expect(json[:the_percentage_of_users_who_got_compensation].class).to eq(Float)
      expect(csv[:distribution_of_the_number_of_fellow_passenger_per_user].class).to eq(Integer)
      expect(csv[:the_average_compensation_per_passenger].class).to eq(Float)
      expect(csv[:the_most_popular_airline_chosen_by_passengers].class).to eq(String)
      expect(csv[:the_percentage_of_users_who_got_compensation].class).to eq(Float)
    end
  end
end
