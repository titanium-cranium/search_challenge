# frozen_string_literal: true

# user class
class User
  attr_reader(:id, :name, :created_at, :verified)

  def initialize(id:, name:, created_at:, verified:)
    @id = id
    @name = name
    @created_at = created_at
    @verified = verified
  end
end
