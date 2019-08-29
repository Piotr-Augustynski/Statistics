# frozen_string_literal: true

require_relative 'spec_helper'

describe DataConverter do
  describe 'supported_file?' do
    it 'return true' do
      expect(DataConverter.supported_file?('json')).to eq(true)
      expect(DataConverter.supported_file?('csv')).to eq(true)
    end

    it 'return false' do
      expect(DataConverter.supported_file?('xml')).to eq(false)
      expect(DataConverter.supported_file?('excel')).to eq(false)
      expect(DataConverter.supported_file?('pdf')).to eq(false)
      expect(DataConverter.supported_file?('docx')).to eq(false)
    end
  end

  describe '#call' do
    json_data = DataLoader.new(File.join(File.dirname(__FILE__), 'files', 'data.json')).call.first
    csv_data = DataLoader.new(File.join(File.dirname(__FILE__), 'files', 'data.csv')).call.first
    json = DataConverter.new(json_data, 'json').call
    csv = DataConverter.new(csv_data, 'csv').call
    first_element_of_from_json = json.first
    last_element_of_from_csv = csv.last

    it 'return type of Array' do
      expect(json.class).to eq(Array)
      expect(csv.class).to eq(Array)
    end

    it 'return Array of Hash elements' do
      expect(json.first.class).to eq(Hash)
      expect(json.last.class).to eq(Hash)
      expect(csv.first.class).to eq(Hash)
      expect(csv.last.class).to eq(Hash)
    end

    it 'return correct keys' do
      expect(first_element_of_from_json.keys).to include('message')
      expect(first_element_of_from_json.keys).to include('airline_code')
      expect(last_element_of_from_csv.keys).to include('number_of_fellow_passenger')
      expect(last_element_of_from_csv.keys).to include('did_receive_compensation')
      expect(first_element_of_from_json.keys).to include('total_compensation_amount')
      expect(last_element_of_from_csv.keys).to include('total_compensation_amount')
    end

    it 'return correct values from json' do
      expect(first_element_of_from_json['message']).to eq('id sapien in')
      expect(first_element_of_from_json['airline_code']).to eq('PID')
      expect(first_element_of_from_json['number_of_fellow_passenger']).to eq(1)
      expect(first_element_of_from_json['did_receive_compensation']).to eq(true)
      expect(first_element_of_from_json['total_compensation_amount']).to eq(60)
    end

    it 'return correct values from csv' do
      expect(last_element_of_from_csv['message']).to eq('eget rutrum at lorem')
      expect(last_element_of_from_csv['airline_code']).to eq('FTS')
      expect(last_element_of_from_csv['number_of_fellow_passenger']).to eq('4')
      expect(last_element_of_from_csv['did_receive_compensation']).to eq('true')
      expect(last_element_of_from_csv['total_compensation_amount']).to eq('21')
    end
  end
end
