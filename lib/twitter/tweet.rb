# frozen_string_literal: true
module Twitter
  class Tweet
    attr_reader :id, :created_at, :text

    def initialize(data)
      p data
      @id = data['id']
      @created_at = DateTime.parse(data['created_at'])
      @text = data['text']
    end

    def self.search(*tags, using_client:)
      client = using_client
      client.search_tweets(tags).map { |data| Tweet.new(data) }
    end
  end
end
