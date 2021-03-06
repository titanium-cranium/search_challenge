# frozen_string_literal: true

require_relative './user'
require_relative './ticket'

# Command Line Interface
class SearchZendesk
  def self.start
    response = nil
    while response != 'quit'
      puts "\n\n"
      puts 'Welcome to Zendesk search'
      puts 'Type quit to exit at any time, press Enter to continue'
      response = $stdin.gets.chomp == 'quit' ? exit(true) : select
    end
    exit(true)
  end

  def self.select
    puts "\n\n"
    puts 'Select Search Options'
    puts '* Press 1 to search Zendesk'
    puts '* Press 2 to view a list of searchable fields'
    response = $stdin.gets.chomp
    case response
    when '1'
      search_zendesk
    when '2'
      list_fields
    when 'quit'
      exit(true)
    else
      puts 'Only (1) or (2) are allowed'
    end
  end

  def self.search_zendesk
    puts "\n\n"
    puts 'Select (1) Users or (2) Tickets'
    response = $stdin.gets.chomp
    case response
    when '1'
      search('User')
    when '2'
      search('Ticket')
    when 'quit'
      exit(true)
    else
      puts('Only (1) or (2) are allowed')
    end
  end

  def self.list_fields
    puts '------------------'
    puts 'Search users with'
    puts attributes(User.new(id: -1).describe)
    puts '------------------'
    puts 'Search tickets with'
    puts attributes(Ticket.new(id: -1).describe)
  end

  def self.search(model)
    puts 'Enter search term'
    search_term = get_search_term(model)
    return if search_term.nil?

    puts 'Enter search value'
    search_value = get_search_value(search_term, model)

    obj_array = Object.const_get(model).search(search_term: search_term, search_value: search_value)
    if obj_array.empty?
      puts "Sorry, no #{model.downcase}s were found."
    else
      obj_array.each do |obj|
        output(obj.describe(include_associations: true))
      end
    end
  end

  def self.get_search_term(model)
    search_term = $stdin.gets.chomp
    valid = valid_search_term?(model, search_term)
    if valid
      search_term = search_term.tr('_', '') if search_term == '_id'
    else
      puts "#{search_term} is not a valid search term" unless valid
      search_term = nil
    end
    search_term
  end

  def self.get_search_value(search_term, model)
    search_value = $stdin.gets.chomp
    search_value = search_value.to_i if search_term == 'id' && model == 'User'
    search_value = nil if search_value == ''
    search_value
  end

  def self.output(model_hash)
    model_hash.map { |k, v| puts "#{k}: #{v}" }
    puts
  end

  def self.attributes(model_hash)
    puts model_hash.map { |k, _| k.to_s }
  end

  def self.valid_search_term?(model, search_term)
    Object.const_get(model).new(id: -1).describe.keys.map(&:to_s).include?(search_term)
  end
end
