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

  describe '.all' do
    it 'retrieves all users' do
      expect(User.all.count).to eq(75)
    end
  end

  describe '.search' do
    let(:user) { User.search(search_term: 'name', search_value: 'Harris Côpeland') }
    it 'retrieves all users that match the criteria' do
      expect(user.first.id).to eq(24)
    end
  end

  describe '#to_s' do
    it 'prints the user details to the console' do
      user = User.all.first
      expect do
        user.to_s
      end.to output("_id: 1\nname: Francisca Rasmussen\ncreated_at: 2016-04-15T05:19:46-10:00\nverified: true\n\n").to_stdout
    end
  end
end
