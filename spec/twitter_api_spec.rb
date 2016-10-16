require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'
require './lib/twitter_lib.rb'
require_relative '../script'
CREDENTIALS = YAML.load(File.read('config/credentials.yml'))
tag_text = 'food'
tags = "#food"


describe 'Be able to authorized by twitter' do
  before do
    Twitter::Client.new(api_key: CREDENTIALS["api_key"], api_secret: CREDENTIALS["api_secret"])
  end
  it 'HAPPY: should be authenticated by twitter' do
  last_response = HTTParty.get('https://api.twitter.com/1.1/search/tweets.json',
                 headers: default_headers,
                 query: { q: tags})
    _(last_response.code).must_equal 200
  end

  it 'SAD: should NOT be authenticated by twitter' do
  last_response = HTTParty.get('https://api.twitter.com/1.1/search/tweets.json',
                 query: { q: tags })
    _(last_response.code).must_equal 400
  end
end

describe 'Be able to get tweets with specific Hashtags' do
  before do
  Twitter::Client.new(api_key: CREDENTIALS["api_key"], api_secret: CREDENTIALS["api_secret"])
  end
  it 'HAPPY: should be able to find tweets' do
  last_response = HTTParty.get('https://api.twitter.com/1.1/search/tweets.json',
                 headers: default_headers,
                 query: { q: tags})
    _(last_response.count).must_be :>, 0
  end

  it 'HAPPY: should be able to find tweets WITH specific hashtags' do
    last_response = HTTParty.get('https://api.twitter.com/1.1/search/tweets.json',
                 headers: default_headers,
                 query: { q: tags})
    result = last_response['statuses'][0]['entities']['hashtags'].map{|item| item['text']}
    _(result).must_include tag_text
  end
end
