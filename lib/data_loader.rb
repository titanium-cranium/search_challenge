# frozen_string_literal: true

require 'json'

# DataLoader class
class DataLoader
  attr_reader :data_type, :data

  DATA_TYPES = %w[users tickets].freeze

  def initialize(data_type:)
    @data = read_data(data_type)
  end

  def read_data(data_type)
    File.read("data/#{data_type}.json")
  end
end
