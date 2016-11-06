# frozen_string_literal: true
require 'yaml'
require 'httparty'

module TweetSearch
  class TwitterClient
    API_BASE = 'https://api.twitter.com/'
    API_VERSION = '1.1/'
    SEARCH_TWEET_ENDPOINT = URI.join(API_BASE, API_VERSION, 'search/tweets.json')

    def self.config=(conf)
      @config ? @config.update(conf) : (@config = conf)
    end

    def self.config
      @config ||= { access_token: ENV['access_token'] }
    end

    def self.search_tweets(*tags)
      HTTParty.get(SEARCH_TWEET_ENDPOINT,
                   headers: authorization_header,
                   query: { q: tags.join(' ') }).parsed_response['statuses']
    end

    def self.authorization_header
      @authorization_header ||= { Authorization: "Bearer #{config[:access_token]}" }
    end
  end
end
