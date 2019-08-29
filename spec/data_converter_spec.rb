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
    let(:json) do 
      json_data = DataLoader.new(File.join(File.dirname(__FILE__), 'files', 'data.json')).call.first
      DataConverter.new(json_data, 'json').call
    end
    let(:csv) do 
      csv_data = DataLoader.new(File.join(File.dirname(__FILE__), 'files', 'data.csv')).call.first
      DataConverter.new(csv_data, 'csv').call
    end

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
      expect(json.first.keys).to include('message')
      expect(json.first.keys).to include('airline_code')
      expect(csv.last.keys).to include('number_of_fellow_passenger')
      expect(csv.last.keys).to include('did_receive_compensation')
      expect(json.first.keys).to include('total_compensation_amount')
      expect(csv.last.keys).to include('total_compensation_amount')
    end

    it 'return correct values from json' do
      expect(json.first['message']).to eq('id sapien in')
      expect(json.first['airline_code']).to eq('PID')
      expect(json.first['number_of_fellow_passenger']).to eq(1)
      expect(json.first['did_receive_compensation']).to eq(true)
      expect(json.first['total_compensation_amount']).to eq(60)
    end

    it 'return correct values from csv' do
      expect(csv.last['message']).to eq('eget rutrum at lorem')
      expect(csv.last['airline_code']).to eq('FTS')
      expect(csv.last['number_of_fellow_passenger']).to eq('4')
      expect(csv.last['did_receive_compensation']).to eq('true')
      expect(csv.last['total_compensation_amount']).to eq('21')
    end
  end
end
