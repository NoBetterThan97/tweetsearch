# frozen_string_literal: true
require 'yaml'
require 'base64'
require 'httparty'

module Twitter
  class Client
    def initialize(api_key:, api_secret:)
      @api_key = api_key
      @api_secret = api_secret
    end

    def search_tweets(*tags)
      HTTParty.get('https://api.twitter.com/1.1/search/tweets.json',
                   headers: authorization_header,
                   query: { q: tags.join(' ') }).parsed_response['statuses']
    end

    private

    def oauth_token
      @oauth_token ||= Base64.urlsafe_encode64("#{@api_key}:#{@api_secret}")
    end

    def authorization_response
      @authorization_response ||= HTTParty.post('https://api.twitter.com/oauth2/token',
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
