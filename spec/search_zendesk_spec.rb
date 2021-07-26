# frozen_string_literal: true

require 'rspec'
require_relative '../lib/search_zendesk'
require_relative '../lib/user'

describe 'SearchZendesk' do
  let(:user_data) do
    User.new(id: 1, name: 'Alan Turing', created_at: '1912-06-23T03:12:09-00:00', verified: true).describe
  end

  let(:ticket_data) do
    Ticket.new(id: 1, created_at: '1944-06-06T04:00:00+01:00', type: 'eureka', subject: 'Enigma', assignee_id: 1,
               tags: ['Bletchley Park', 'Omaha Beach', 'Berlin', 'London']).describe
  end

  describe '.output' do
    it 'outputs model instance details to STDOUT' do
      expect do
        SearchZendesk.output(user_data)
      end.to output("_id: 1\nname: Alan Turing\ncreated_at: 1912-06-23T03:12:09-00:00\nverified: true\n\n").to_stdout
      expect do
        SearchZendesk.output(ticket_data)
      end.to output("_id: 1\ncreated_at: 1944-06-06T04:00:00+01:00\ntype: eureka\nsubject: Enigma\nassignee_id: 1\ntags: [\"Bletchley Park\", \"Omaha Beach\", \"Berlin\", \"London\"]\n\n").to_stdout
    end

    describe '.attributes' do
      it 'outputs the keys to STDOUT' do
        expect { SearchZendesk.attributes(user_data) }.to output("_id\nname\ncreated_at\nverified\n").to_stdout
        expect do
          SearchZendesk.attributes(ticket_data)
        end.to output("_id\ncreated_at\ntype\nsubject\nassignee_id\ntags\n").to_stdout
      end
    end
  end
end
