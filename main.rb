require 'faraday'
require 'nokogiri'
require 'json'
require 'slack-ruby-client'

require_relative 'config'
require_relative 'client'
require_relative 'bot'

Bot.new.run
