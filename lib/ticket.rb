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

  def initialize(id:, created_at: '', type: '', subject: '', tags: [], assignee_id: -1)
    @id = id
    @created_at = created_at
    @type = type
    @subject = subject
    @assignee_id = assignee_id
    @tags = tags
  end

  def user
    # this makes an assumption that all tickets have only one assignee
    DataLibrary.users.select { |user| user.id == assignee_id }.first
  end

  def describe(include_associations: false)
    hash = {
      _id: id,
      created_at: created_at,
      type: type,
      subject: subject,
      assignee_id: assignee_id,
      tags: tags
    }
    hash[:assignee_name] = user&.name if include_associations
    hash
  end
end
