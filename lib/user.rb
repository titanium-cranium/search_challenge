# frozen_string_literal: true

require_relative './data_library'

# user class
class User
  attr_reader(:id, :name, :created_at, :verified)

  def self.all
    DataLibrary.users
  end

  def self.search(search_term:, search_value:)
    all.select { |user| user.public_send(search_term) == search_value }
  end

  def initialize(id:, name: '', created_at: '', verified: false)
    @id = id
    @name = name
    @created_at = created_at
    @verified = verified
  end

  def tickets
    DataLibrary.tickets.select { |ticket| ticket.assignee_id == id }
  end

  def describe(include_associations: false)
    hash = {
      _id: id,
      name: name,
      created_at: created_at,
      verified: verified
    }
    hash[:tickets] = tickets.map(&:subject) if include_associations
    hash
  end
end
