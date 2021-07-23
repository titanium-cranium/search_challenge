# frozen_string_literal: true

require_relative './data_library'

# ticket class
class Ticket
  attr_reader(:id, :created_at, :type, :subject, :assignee_id, :tags)

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
end
