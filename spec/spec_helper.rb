# frozen_string_literal: true
require 'simplecov'
SimpleCov.start

require 'vcr'
require 'yaml'
require 'dotenv'
require 'webmock'
require 'minitest/rg'
require 'minitest/autorun'

require_relative '../lib/tweetsearch/twitter_client.rb'
require_relative '../lib/tweetsearch/tweet.rb'

Dotenv.load

CASSETTES_FOLDER = 'spec/support/cassettes'
TAGS = ['#food', '#yum'].freeze

VCR.configure do |config|
  config.cassette_library_dir = CASSETTES_FOLDER
  config.hook_into :webmock

  config.filter_sensitive_data('<ACCESS_TOKEN>') { ENV['ACCESS_TOKEN'] }
end

def cassette_name(path_to_spec, description)
  spec_filename = File.basename(path_to_spec, '.*')
  spec_description = description.gsub(/^test_[0-9]+_/, '')

  "#{spec_filename} #{spec_description}"
end
