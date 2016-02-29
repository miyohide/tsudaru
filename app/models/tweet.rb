# coding: utf-8
class Tweet < ActiveRecord::Base
  attr_accessible :message
  validates :message, length: { maximum: 140 }

  # 与えられた引数を組み立ててツイートするメッセージを作成する
  def self.create_full_message(params)
    # Hashtagを表す#は意図的に付与しない
    "#{params[:tweet_opt][:speaker]}「#{params[:tweet][:message]}」 #{params[:tweet_opt][:hashtag]}"
  end

  def tweet
    TwitterAPI.new.client.update(self.message)
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
end
