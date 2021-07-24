# frozen_string_literal: true

require_relative './data_library'

# ticket class
class Ticket
  attr_reader(:id, :created_at, :type, :subject, :assignee_id, :tags)

  def self.all
    DataLibrary.tickets
  end

  def self.search(search_term:, search_value:)
    all.select { |ticket| ticket.public_send(search_term) == search_value }
  end

  def initialize(id:, created_at:, type:, subject:, tags:, assignee_id: -1)
    @id = id
    @created_at = created_at
    @type = type
    @subject = subject
    @assignee_id = assignee_id
    @tags = tags
  end

  def user
    DataLibrary.users.select { |user| user.id == assignee_id }.first
  end

  def to_s
    puts "_id: #{id}" if id
    puts "created_at: #{created_at}" if created_at
    puts "type: #{type}" if type
    puts "subject: #{subject}" if subject
    puts "assignee_id: #{assignee_id}" if assignee_id
    puts "tags: #{tags}" if tags
    puts "assignee_name: #{user.name}" if user
    puts "\n"
  end
end
