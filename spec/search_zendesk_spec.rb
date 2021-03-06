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

  describe '.start' do
    context 'the user wants to exit' do
      it 'exits the user from the program' do
        allow($stdin).to receive(:gets).and_return('quit')
        expect { SearchZendesk.start }.to raise_error(SystemExit)
      end
    end
  end

  describe '.select' do
    context 'gives the user a choice and calls the appropriate method' do
      it 'calls search_zendesk when the user enters 1' do
        allow($stdin).to receive(:gets).and_return('1')
        expect(SearchZendesk).to receive(:search_zendesk)
        SearchZendesk.select
      end

      it 'calls list_fields when the user enters 2' do
        allow($stdin).to receive(:gets).and_return('2')
        expect(SearchZendesk).to receive(:list_fields)
        SearchZendesk.select
      end

      it 'outputs an error message if 1 or 2 are not entered' do
        allow($stdin).to receive(:gets).and_return('3')
        expect do
          SearchZendesk.select
        end.to output("\n\nSelect Search Options\n* Press 1 to search Zendesk\n* Press 2 to view a list of searchable fields\nOnly (1) or (2) are allowed\n").to_stdout
      end

      it 'exits the user from the program' do
        allow($stdin).to receive(:gets).and_return('quit')
        expect { SearchZendesk.select }.to raise_error(SystemExit)
      end
    end
  end

  describe '.search_zendesk' do
    context 'gives the user a choice and calls the appropriate method' do
      it "calls search('User') when the user enters 1" do
        allow($stdin).to receive(:gets).and_return('1')
        expect(SearchZendesk).to receive(:search).with('User')
        SearchZendesk.search_zendesk
      end

      it "calls search('Ticket') when the user enters 1" do
        allow($stdin).to receive(:gets).and_return('2')
        expect(SearchZendesk).to receive(:search).with('Ticket')
        SearchZendesk.search_zendesk
      end

      it 'outputs an error message if 1 or 2 are not entered' do
        allow($stdin).to receive(:gets).and_return('3')
        expect do
          SearchZendesk.search_zendesk
        end.to output("\n\nSelect (1) Users or (2) Tickets\nOnly (1) or (2) are allowed\n").to_stdout
      end

      it 'exits the user from the program' do
        allow($stdin).to receive(:gets).and_return('quit')
        expect { SearchZendesk.search_zendesk }.to raise_error(SystemExit)
      end
    end
  end

  describe '.search' do
    let(:user) { User.all.first }
    let(:model) { 'User' }
    let(:search_term) { 'name' }
    context 'the user searches successfully' do
      it 'successfully searches the user model for a name' do
        allow(SearchZendesk).to receive(:get_search_term).and_return('name')
        allow(SearchZendesk).to receive(:get_search_value).with(search_term, model).and_return('Francisca Rasmussen')
        expect do
          SearchZendesk.search('User')
        end.to output("Enter search term\nEnter search value\n_id: 1\nname: Francisca Rasmussen\ncreated_at: 2016-04-15T05:19:46-10:00\nverified: true\ntickets: [\"A Problem in Russian Federation\", \"A Problem in Malawi\"]\n\n").to_stdout
      end

      it 'tells the user there were no matching models' do
        allow(SearchZendesk).to receive(:get_search_term).and_return('name')
        allow(SearchZendesk).to receive(:get_search_value).with(search_term, model).and_return('Blargle')
        expect do
          SearchZendesk.search('User')
        end.to output("Enter search term\nEnter search value\nSorry, no users were found.\n").to_stdout
      end
    end
  end

  describe '.get_search_term' do
    let(:model) { 'User' }
    it 'returns a valid_search term' do
      allow($stdin).to receive(:gets).and_return('name')
      expect(SearchZendesk.get_search_term(model)).to eq('name')
    end

    it 'tells the user the search_term is invalid' do
      allow($stdin).to receive(:gets).and_return('blargle')
      expect { SearchZendesk.get_search_term(model) }.to output("blargle is not a valid search term\n").to_stdout
      expect(SearchZendesk.get_search_term(model)).to be(nil)
    end
  end

  describe '.get_search_value' do
    let(:model) { 'User' }
    it 'returns an unformatted search value' do
      search_term = 'name'
      allow($stdin).to receive(:gets).and_return('Francisca Rasmussen')
      expect(SearchZendesk.get_search_value(search_term, model)).to eq('Francisca Rasmussen')
    end

    it 'formats value to integer if search_term equals _id' do
      search_term = 'id'
      allow($stdin).to receive(:gets).and_return('24')
      expect(SearchZendesk.get_search_value(search_term, model)).to eq(24)
    end

    it 'returns nil if the search_value is an empty string' do
      search_term = 'assignee_id'
      allow($stdin).to receive(:gets).and_return('')
      expect(SearchZendesk.get_search_value(search_term, model)).to eq(nil)
    end

    it 'tells the user the search_term is invalid' do
      allow($stdin).to receive(:gets).and_return('blargle')
      expect { SearchZendesk.get_search_term(model) }.to output("blargle is not a valid search term\n").to_stdout
      expect(SearchZendesk.get_search_term(model)).to eq(nil)
    end
  end

  describe '.list_fields' do
    it 'lists the searchable fields of the models' do
      expect do
        SearchZendesk.list_fields
      end.to output("------------------\nSearch users with\n_id\nname\ncreated_at\nverified\n\n------------------\nSearch tickets with\n_id\ncreated_at\ntype\nsubject\nassignee_id\ntags\n\n").to_stdout
    end
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

    describe '.valid_search_term?' do
      let(:valid_search_term) { 'name' }
      let(:invalid_search_term) { 'blargle' }
      it 'returns true if search term entered is included in model attributes' do
        expect(SearchZendesk.valid_search_term?('User', valid_search_term)).to be_truthy
      end

      it 'returns false if search term entered is included in model attributes' do
        expect(SearchZendesk.valid_search_term?('User', invalid_search_term)).to be_falsey
      end
    end
  end
end
