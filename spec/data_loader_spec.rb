# frozen_string_literal: true

require 'rspec'
require 'json'
require_relative '../lib/data_loader'

RSpec.describe DataLoader do
  describe '#initialize' do
    let(:user_data) { JSON.parse(DataLoader.new(data_type: 'users').data) }
    it 'loads the user data into memory' do
      expect(user_data.count).to be(75)
    end
  end
end
