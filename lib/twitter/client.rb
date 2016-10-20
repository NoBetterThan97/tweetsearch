# frozen_string_literal: true
require 'yaml'
require 'httparty'

module Twitter
  class Client
    API_BASE = 'https://api.twitter.com/'
    API_VERSION = '1.1/'
    SEARCH_TWEET_ENDPOINT = URI.join(API_BASE, API_VERSION, 'search/tweets.json')

    def initialize(access_token:)
      @access_token = access_token
    end

    def search_tweets(*tags)
      HTTParty.get(SEARCH_TWEET_ENDPOINT,
                   headers: authorization_header,
                   query: { q: tags.join(' ') }).parsed_response['statuses']
    end

    private

    def authorization_header
      @authorization_header ||= { Authorization: "Bearer #{@access_token}" }
    end
  end
end
