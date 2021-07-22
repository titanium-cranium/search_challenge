# frozen_string_literal: true

# user class
class User
  attr_reader(:_id, :name, :created_at, :verified)

  def initialize(_id:, name:, created_at:, verified:)
    @_id = _id
    @name = name
    @created_at = created_at
    @verified = verified
  end
end
