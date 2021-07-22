# frozen_string_literal: true

require 'rspec'
require 'json'
require_relative '../lib/data_library'
require_relative '../lib/data_loader'
require_relative '../lib/user'
require_relative '../lib/ticket'

RSpec.describe DataLibrary do
  describe '#users' do
    let(:users) { DataLibrary.users }
    it 'creates a user library' do
      expect(users.count).to be(75)
    end

    let(:user) { DataLibrary.users.first}
    it 'user library includes User objects' do
      expect(user.class.to_s).to eq("User")
    end
  end

  describe "#tickets" do
    let(:tickets) { DataLibrary.tickets }
    it 'creates a ticket library' do
      expect(tickets.count).to be(200)
    end

    let(:ticket) { DataLibrary.tickets.first}
    it 'ticket library includes Ticket objects' do
      expect(ticket.class.to_s).to eq("Ticket")
    end
  end
end
