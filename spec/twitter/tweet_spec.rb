# frozen_string_literal: true
require_relative '../spec_helper.rb'

describe 'Twitter::Tweet::search' do
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
