# frozen_string_literal: true
require_relative '../spec_helper.rb'

describe 'TweetSearch::TwitterClient::search_tweets' do
  before do
    VCR.insert_cassette(cassette_name(__FILE__, name), record: :new_episodes)
  end

  after do
    VCR.eject_cassette
  end

  it 'should return Tweets that contain specific hashtags' do
    TweetSearch::TwitterClient.search_tweets(TAGS).wont_be_nil
  end
end
