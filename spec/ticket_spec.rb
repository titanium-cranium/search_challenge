# frozen_string_literal: true

require 'rspec'
require_relative '../lib/ticket'

RSpec.describe Ticket do
  describe '#initialize' do
    let(:ticket) do
      Ticket.new(id: 'b07a8c20-2ee5-493b-9ebf-f6321b95966e', created_at: '2016-03-21T11:18:13-11:00', type: 'question',
                 subject: 'a cold day in Melbourne', assignee_id: 24, tags: ['victoria', 'new south wales'])
    end

    let(:unassigned_ticket) do
      Ticket.new(id: 'b07a8c20-2ee5-493b-9ebf-f6321b95966e', created_at: '2016-03-21T11:18:13-11:00', type: 'question',
                 subject: 'a cold day in Melbourne', tags: ['victoria', 'new south wales'])
    end

    it 'sets the assignee_id to the given value' do
      expect(ticket.assignee_id).to be(24)
    end

    it 'sets the assignee_id to the default value' do
      expect(unassigned_ticket.assignee_id).to be(-1)
    end
  end

  describe '#user' do
    let(:ticket) do
      Ticket.new(
        id: '436bf9b0-1147-4c0a-8439-6f79833bff5b',
        created_at: '2016-04-28T11:19:34-10:00',
        type: 'incident',
        subject: 'A Catastrophe in Korea (North)',
        assignee_id: 24,
        tags: [
          'Ohio',
          'Pennsylvania',
          'American Samoa',
          'Northern Mariana Islands'
        ]
      )
    end

    it 'returns the user assigned to the ticket' do
      expect(ticket.user.name).to eq('Harris Côpeland')
    end
  end

  describe '.all' do
    let(:tickets) { Ticket.all }
    it 'retrives all tickets in data library' do
      expect(tickets.count).to eq(200)
    end
  end

  describe '.search' do
    let(:tickets) { Ticket.search(search_term: 'type', search_value: 'incident') }
    it 'retrieves all tickets limited by search term & value' do
      expect(tickets.count).to eq(35)
    end
  end

  describe '#describe' do
    let(:ticket) { Ticket.all.first }
    it 'returns the ticket details in a hash' do
      expect(ticket.describe).to eq({ _id: '436bf9b0-1147-4c0a-8439-6f79833bff5b',
                                      created_at: '2016-04-28T11:19:34-10:00', type: 'incident', subject: 'A Catastrophe in Korea (North)', assignee_id: 24, tags: ['Ohio', 'Pennsylvania', 'American Samoa', 'Northern Mariana Islands'] })
    end

    it 'includes the ticket subjects' do
      expect(ticket.describe(include_associations: true)).to eq({ _id: '436bf9b0-1147-4c0a-8439-6f79833bff5b',
                                                                  created_at: '2016-04-28T11:19:34-10:00', type: 'incident', subject: 'A Catastrophe in Korea (North)', assignee_id: 24, tags: ['Ohio', 'Pennsylvania', 'American Samoa', 'Northern Mariana Islands'], assignee_name: 'Harris Côpeland' })
    end
  end
end
