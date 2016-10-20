# frozen_string_literal: true
require 'yaml'
require 'vcr'
require 'webmock'

require 'minitest/autorun'
require 'minitest/rg'
require_relative '../../lib/twitter/client.rb'
require_relative '../../lib/twitter/tweet.rb'

FIXTURES_FOLDER = 'spec/fixtures'
CASSETTES_FOLDER = "#{FIXTURES_FOLDER}/cassettes"
CREDENTIALS = YAML.load(File.read('../../config/credentials.yml'))
CLIENT = Twitter::Client.new(access_token: CREDENTIALS['access_token'])
tags = '#food'

describe 'Twitter::Tweet::search' do

  VCR.configure do |c|
    c.cassette_library_dir = CASSETTES_FOLDER
    c.hook_into :webmock

    c.filter_sensitive_data('<ACCESS_TOKEN>') { CREDENTIALS[:access_token] }
    c.filter_sensitive_data('<ACCESS_TOKEN_ESCAPED>') do
      URI.escape(CREDENTIALS[:access_token])
    end
  end

  before do
    VCR.insert_cassette CASSETTE_FILE, record: :new_episodes

    @client = Twitter::Client.new(
      access_token: CREDENTIALS[:access_token]
    )
  end

  after do
    VCR.eject_cassette
  end
end
