# coding: utf-8
class Tweet < ActiveRecord::Base
  attr_accessible :message, :hashtag, :speaker
  validate :tweet_message_less_than_140

  def tweet
    TwitterAPI.new.client.update(create_tweet_message)
    self.tweeted = true
    self.save
  rescue Twitter::Error => e
    if e.code == Twitter::Error::DuplicateStatus
      self.tweeted = true
      self.save
    else
     raise
    end
  end

  def tweet_message_less_than_140
    tweet_message = create_tweet_message
    if tweet_message.length > 140
      errors.add(:message, ": は140文字以内としてください")
    end
  end

  def create_tweet_message
    # Hashtagを表す#は意図的に付与しない
    "#{speaker}「#{message}」#{hashtag}"
  end
end
