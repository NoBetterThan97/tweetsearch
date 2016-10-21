# frozen_string_literal: true
require 'simplecov'
SimpleCov.start

require './spec/spec_helper.rb'
require './lib/twitter/client.rb'
require './lib/twitter/tweet.rb'

describe 'Twitter::Tweet::search' do
  before do
    @client = Twitter::Client.new(access_token: CREDENTIALS['access_token'])
  end

  it 'should return Tweets that contain specific hashtags' do
    tweets = Twitter::Tweet.search(TAGS, using_client: @client)
    tweets.length.must_be :>, 0
  end
end
