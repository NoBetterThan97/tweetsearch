# frozen_string_literal: true
require_relative '../spec_helper.rb'

describe 'Twitter::Tweet::search' do
VCR.configure do |c|
    c.cassette_library_dir = CASSETTES_FOLDER
    c.hook_into :webmock

    c.filter_sensitive_data('<ACCESS_TOKEN>') { CREDENTIALS[:access_token] }
    c.filter_sensitive_data('<ACCESS_TOKEN_ESCAPED>') do
      URI.parse(URI.encode(CREDENTIALS[:access_token].to_s))
      #URI.escape(CREDENTIALS[:access_token])
    end
  end


  before do
    VCR.insert_cassette(cassette_name(__FILE__, name), record: :new_episodes)

    @client = Twitter::Client.new(access_token: CREDENTIALS['access_token'])
  end

  after do
    VCR.eject_cassette
  end

  it 'should return Tweets that contain specific hashtags' do
    tweets = Twitter::Tweet.search(TAGS, using_client: @client)
    tweets.length.must_be :>, 0
  end
end
