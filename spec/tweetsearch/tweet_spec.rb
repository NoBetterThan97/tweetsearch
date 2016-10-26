# frozen_string_literal: true
require_relative '../spec_helper.rb'

describe 'TweetSearch::Tweet::search' do
  before do
    VCR.insert_cassette(cassette_name(__FILE__, name), record: :new_episodes)

    @client = TweetSearch::TwitterClient.new(access_token: ENV['access_token'])
  end

  after do
    VCR.eject_cassette
  end

  it 'should return Tweets that contain specific hashtags' do
    tweets = TweetSearch::Tweet.search(TAGS, using_client: @client)
    tweets.length.must_be :>, 0
  end
end
