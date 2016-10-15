# frozen_string_literal: true
require 'yaml'
require 'base64'
require 'httparty'

moduel Twitter

  class Client

    attr_reader :default_header
  
  def initialize(api_key:, api_secrte:)
    @oauth_token ||= Base64.urlsafe_encode64("#{api_key}:#{api_secret}")
    @default_header = default_headers
  end

  def search_tweets(*tags)
    HTTParty.get('https://api.twitter.com/1.1/search/tweets.json',
                 headers: default_header,
                 query: { q: tags.join(' ') }).parsed_response['statuses']
  end
    
  def authorize!
    HTTParty.post('https://api.twitter.com/oauth2/token',
                  headers: { Authorization: "Basic #{oauth_token}" },
                  query: { grant_type: 'client_credentials' }).parsed_response
  end

  def default_headers
    authorization_response = authorize!
    @deafult_headers ||= {
      Authorization: "#{authorization_response['token_type'].upcase} #{authorization_response['access_token']}"
    }
  end



end
