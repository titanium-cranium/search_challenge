# frozen_string_literal: true

require_relative './data_library'

# user class
class User
  attr_reader(:id, :name, :created_at, :verified)

  def self.search(search_term:, search_value:)
    # TODO: handle case where search term doesn't exist
    # TODO: handle case gracefully where no users are returned
    DataLibrary.users.select { |user| user.public_send(search_term) == search_value.to_s }
  end

  def self.all
    DataLibrary.users
  end

  def initialize(id:, name:, created_at:, verified:)
    @id = id
    @name = name
    @created_at = created_at
    @verified = verified
  end

  def tickets
    DataLibrary.tickets.select { |ticket| ticket.assignee_id == id }
  end
end
