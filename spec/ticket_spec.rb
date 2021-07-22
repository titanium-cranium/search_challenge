# frozen_string_literal: true

require 'rspec'
require_relative '../lib/ticket'

RSpec.describe Ticket do
  let(:ticket) do
    Ticket.new(_id: 'b07a8c20-2ee5-493b-9ebf-f6321b95966e', created_at: '2016-03-21T11:18:13-11:00', type: 'question',
               subject: 'a cold day in Melbourne', assignee_id: 24, tags: ['victoria', 'new south wales'])
  end

  let(:unassigned_ticket) do
    Ticket.new(_id: 'b07a8c20-2ee5-493b-9ebf-f6321b95966e', created_at: '2016-03-21T11:18:13-11:00', type: 'question',
               subject: 'a cold day in Melbourne', tags: ['victoria', 'new south wales'])
  end

  describe '#initialize' do
    it 'sets the assignee_id to the given value' do
      expect(ticket.assignee_id).to be(24)
    end

    it 'sets the assignee_id to the default value' do
      expect(unassigned_ticket.assignee_id).to be(-1)
    end
  end
end
