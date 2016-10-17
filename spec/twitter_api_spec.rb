# frozen_string_literal: true
require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'
require './lib/twitter_lib.rb'

CREDENTIALS = YAML.load(File.read('config/credentials.yml'))
tag_text = 'food'
tags = '#food'

describe 'Be able to authorized by twitter' do
  before do
    Twitter::Client.new(api_key: CREDENTIALS['api_key'], api_secret: CREDENTIALS['api_secret'])
  end

  it 'HAPPY: should be authenticated by twitter' do
    last_response = Twitter::Client.new(api_key: CREDENTIALS['api_key'], api_secret: CREDENTIALS['api_secret'])
    result = last_response.authorize!
    _(result).wont_be_nil
  end
end

describe 'Be able to get tweets with specific Hashtags' do
  before do
    Twitter::Client.new(api_key: CREDENTIALS['api_key'], api_secret: CREDENTIALS['api_secret'])
  end

  it 'HAPPY: should be able to find tweets' do
    last_response = search_tweets(tags)
    _(last_response.count).must_be :>, 0
  end

  it 'HAPPY: should be able to find tweets WITH specific hashtags' do
    last_response = search_tweets(tags)
    result = last_response[0]['entities']['hashtags'].map { |item| item['text'].downcase }
    _(result).must_include tag_text
  end
end
