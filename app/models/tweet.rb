# coding: utf-8
class Tweet < ActiveRecord::Base
  attr_accessible :message
  validates :message, length: { maximum: 140 }

  def self.create_full_message(params)
     # Hashtagを表す#は意図的に付与しない
     message = "#{params[:tweet_opt][:speaker]}「#{params[:tweet][:message]}」 #{params[:tweet_opt][:hashtag]}" 
  end

  def tweet
     if rand(10) > 4
        self.tweeted = true
     else
        self.tweeted = false
     end
     self.save
     sleep 3
  end
end
