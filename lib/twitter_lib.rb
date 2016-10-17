# frozen_string_literal: true
require 'yaml'
require 'base64'
require 'httparty'

module Twitter
  class Client
    API_BASE = 'https://api.twitter.com/'
    API_VERSION = '1.1/'
    SEARCH_TWEET_ENDPOINT = URI.join(API_BASE, API_VERSION, 'search/tweets.json')
    OAUTH_ENDPOINT = URI.join(API_BASE, 'oauth2/token')

    def initialize(api_key:, api_secret:)
      @api_key = api_key
      @api_secret = api_secret
    end

    def search_tweets(*tags)
      HTTParty.get(SEARCH_TWEET_ENDPOINT,
                   headers: authorization_header,
                   query: { q: tags.join(' ') }).parsed_response['statuses']
    end

    private

    def oauth_token
      @oauth_token ||= Base64.urlsafe_encode64("#{@api_key}:#{@api_secret}")
    end

    def authorization_response
      @authorization_response ||= HTTParty.post(OAUTH_ENDPOINT,
                                                headers: { Authorization: "Basic #{oauth_token}" },
                                                query: { grant_type: 'client_credentials' }).parsed_response
    end

    def authorization_header
      @authorization_header ||= {
        Authorization: "#{authorization_response['token_type'].capitalize} #{authorization_response['access_token']}"
      }
    end
  end
end
