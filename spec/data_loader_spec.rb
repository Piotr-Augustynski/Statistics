# frozen_string_literal: true

require_relative 'spec_helper'

describe DataLoader do

  json = DataLoader.new('/Users/Wicek/programming/statistics/spec/files/data.json').call
  csv = DataLoader.new('/Users/Wicek/programming/statistics/spec/files/data.csv').call

  describe '#type of result' do
    it 'return Array' do
      expect(json.class).to eq(Array)
      expect(csv.class).to eq(Array)
    end 
  end

  describe '#count' do
    it 'return sum of all elements' do
      expect(json.count).to eq(2)
      expect(csv.count).to eq(2)
    end
  end

  describe '#type of second argument' do
    it 'return String' do
      expect(json.first.class).to eq(String)
      expect(csv.first.class).to eq(String)
    end 
  end

  describe '#type of first argument' do
    it 'return String' do
      expect(json.last.class).to eq(String)
      expect(csv.last.class).to eq(String)
    end 
  end
end
