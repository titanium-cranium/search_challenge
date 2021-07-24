# frozen_string_literal: true

require_relative './data_loader'
require_relative './user'
require_relative './ticket'

# DataLibrary class
class DataLibrary
  def self.users
    @users ||= load_users
  end

  def self.tickets
    @tickets ||= load_tickets
  end

  def self.load_users(users_json = nil)
    users_json = DataLoader.new(data_type: 'users').data if users_json.nil?
    @users = JSON.parse(users_json).map do |user|
      User.new(id: user['_id'], name: user['name'], created_at: user['created_at'], verified: user['verified'])
    end
  end

  def self.load_tickets(tickets_json = nil)
    tickets_json = DataLoader.new(data_type: 'tickets').data if tickets_json.nil?
    @tickets = JSON.parse(tickets_json).map do |ticket|
      Ticket.new(id: ticket['_id'], created_at: ticket['created_at'], type: ticket['type'],
                 subject: ticket['subject'], assignee_id: ticket['assignee_id'], tags: ticket['tags'])
    end
  end
end
