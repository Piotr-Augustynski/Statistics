# frozen_string_literal: true

require_relative 'spec_helper'

describe DataLoader do
  json = DataLoader.new(File.join(File.dirname(__FILE__), 'files', 'data.json')).call
  csv = DataLoader.new(File.join(File.dirname(__FILE__), 'files', 'data.csv')).call

  describe '#call' do
    it 'return type of Array' do
      expect(json.class).to eq(Array)
      expect(csv.class).to eq(Array)
    end

    it 'return correct sum of all elements' do
      expect(json.count).to eq(2)
      expect(csv.count).to eq(2)
    end

    it 'each of elements are a String' do
      expect(json.first.class).to eq(String)
      expect(csv.first.class).to eq(String)
      expect(json.last.class).to eq(String)
      expect(csv.last.class).to eq(String)
    end
  end
end
