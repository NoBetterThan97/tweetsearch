# frozen_string_literal: true
require 'base64'
require 'httparty'

namespace :util do
  desc 'Generate new access token'
  task :access_token do
    OAUTH_ENDPOINT = 'https://api.twitter.com/oauth2/token'
    credentials = YAML.load_file('config/credentials.yml')
    basic_token = Base64.urlsafe_encode64("#{credentials['api_key']}:#{credentials['api_secret']}")
    token_response = HTTParty.post(OAUTH_ENDPOINT, headers: { Authorization: "Basic #{basic_token}" },
                                                   query: { grant_type: 'client_credentials' }).parsed_response
    puts "Access Token: #{token_response['access_token']}"
  end
end
