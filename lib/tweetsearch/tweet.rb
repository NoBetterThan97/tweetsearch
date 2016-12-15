# frozen_string_literal: true
module TweetSearch
  class Tweet
    attr_reader :id, :created_at, :text, :media_urls

    def initialize(data)
      @id = data['id']
      @created_at = DateTime.parse(data['created_at'])
      @text = data['text']
      @media_urls = data.dig('entities', 'media')&.map { |media| media['media_url_https'] }
    end

    def self.find_by(tags:, media_only: false)
      tweets = TwitterClient.search_tweets(tags)
      tweets.select! { |data| data.dig('entities', 'media') } if media_only
      tweets.map { |data| new(data) }
    end
  end
end
