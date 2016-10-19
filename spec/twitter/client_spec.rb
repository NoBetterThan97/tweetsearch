# frozen_string_literal: true
require './spec/spec_helper.rb'
require './lib/twitter/client.rb'

CREDENTIALS = YAML.load(File.read('config/credentials.yml'))
tags = '#food'

describe 'Twitter::Client#search_tweets' do
  it 'should return Tweets that contain specific hashtags' do
    client = Twitter::Client.new(access_token: CREDENTIALS['access_token'])
    client.search_tweets(tags).wont_be_nil
  end
end
