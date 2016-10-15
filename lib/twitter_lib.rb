# frozen_string_literal: true
require 'yaml'
require 'base64'
require 'httparty'

moduel Twitter

  class Client

  attr_reader :oauth_token, :default_header
  
  def initialize(api_key:,api_secrte:)
    @oauth_token ||= Base64.urlsafe_encode64("#{api_key}:#{api_secret}")
    @default_header = default_headers
  end

  def search_tweets(*tags)
  HTTParty.get('https://api.twitter.com/1.1/search/tweets.json',
               headers: default_headers,
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


#def credentials
#  @credentials ||= YAML.load_file('./config/credentials.yml')
#end

#def oauth_token
#  @oauth_token ||= Base64.urlsafe_encode64("#{credentials['api_key']}:#{credentials['api_secret']}")
#end


if __FILE__ == $PROGRAM_NAME
  print 'Hashtags (separated by space): '
  tags = gets.chomp.split.map { |tag| tag.start_with?('#') ? tag : "##{tag}" }
  puts search_tweets(tags).map { |tweet| tweet['text'] }.join("\n\n")
end
