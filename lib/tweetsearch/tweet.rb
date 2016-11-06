# frozen_string_literal: true
module TweetSearch
  class Tweet
    attr_reader :id, :created_at, :text

    def initialize(data)
      @id = data['id']
      @created_at = DateTime.parse(data['created_at'])
      @text = data['text']
    end

    def self.search(*tags)
      TwitterClient.search_tweets(tags).map { |data| new(data) }
    end
  end
end
