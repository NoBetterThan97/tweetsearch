# frozen_string_literal: true
require './spec/spec_helper.rb'
require './lib/twitter/client.rb'
require './lib/twitter/tweet.rb'

CREDENTIALS = YAML.load(File.read('config/credentials.yml'))
CLIENT = Twitter::Client.new(api_key: CREDENTIALS['api_key'], api_secret: CREDENTIALS['api_secret'])
tags = '#food'

describe 'Twitter::Tweet::search' do
  it 'should return Tweets that contain specific hashtags' do
    tweets = Twitter::Tweet.search(tags, using_client: CLIENT)
    tweets.length.must_be :>, 0
  end
end
