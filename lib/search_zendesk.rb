# frozen_string_literal: true
require 'thor'

class SearchZendesk < Thor

  def initialize
    @search_term = nil
    @search_value = nil
  end

  desc "start", "start the program"
  def start
    response = nil
    while response != "quit"
      puts "\n\n"
      puts "Welcome to Zendesk search"
      puts "Type quit to exit at any time, press Enter to continue"
      response = STDIN.gets.chomp == "quit" ? exit(true) : select
    end
    exit(true)
  end

  def select
    puts "\n\n"
    puts "Select Search Options"
    puts "* Press 1 to search Zendesk"
    puts "* Press 2 to view a list of searchable fields"
    response = STDIN.gets.chomp
    if response == "1"
      search_zendesk
    elsif response == "2"
      list_fields

    else
      return
    end
    response
  end

  def search_zendesk
    puts "\n\n"
    puts "Select (1) Users or (2) Tickets"
    response = STDIN.gets.chomp
    if response == "1"
      user_search
    elsif response == "2"
      ticket_search
    elsif response == "quit"
      exit(true)
    else
      return
    end
    response
  end

  def list_fields
    puts "list_fields"
  end

  def user_search
    puts "user_search"
  end

  def ticket_search
    puts "ticket_search"
  end
end

CLI.start(ARGV)
