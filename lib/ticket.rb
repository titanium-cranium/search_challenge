# frozen_string_literal: true

# ticket class
class Ticket
  attr_reader(:_id, :created_at, :type, :subject, :assignee_id, :tags)

  def initialize(_id:, created_at:, type:, subject:, tags:, assignee_id: -1)
    @_id = _id
    @created_at = created_at
    @type = type
    @subject = subject
    @assignee_id = assignee_id
    @tags = tags
  end
end
