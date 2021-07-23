# frozen_string_literal: true

require 'rspec'
require_relative '../lib/user'
require_relative '../lib/data_library'

RSpec.describe User do
  let(:user) { User.new(id: 24, name: 'Harris Côpeland', created_at: '2016-03-02T03:35:41-11:00', verified: false) }
  let(:tickets) { DataLibrary.tickets }

  describe '#initialize ' do
    it 'creates a User' do
      expect(user.name).to eq('Harris Côpeland')
    end
  end

  describe '#tickets' do
    it 'retrieves all user assigned tickets' do
      expect(user.tickets.count).to eq(4)
    end
  end
end
