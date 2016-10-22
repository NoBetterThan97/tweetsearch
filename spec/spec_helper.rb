# frozen_string_literal: true
require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'
require 'vcr'
require 'webmock'

require_relative '../lib/twitter/client.rb'
require_relative '../lib/twitter/tweet.rb'


FIXTURES_FOLDER = 'fixtures'
CASSETTES_FOLDER = "#{FIXTURES_FOLDER}/cassettes"
CASSETTE_FILE = 'tweets_api'
CREDENTIALS = YAML.load(File.read('./config/credentials.yml'))
CLIENT = Twitter::Client.new(access_token: CREDENTIALS['access_token'])
