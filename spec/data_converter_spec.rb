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
end

