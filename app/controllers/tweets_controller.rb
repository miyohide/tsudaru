# coding: utf-8
class TweetsController < ApplicationController
   def new
      @tweet = Tweet.new
   end

   def create
      @speaker = params[:tweet_opt][:speaker]
      @hashtag = params[:tweet_opt][:hashtag]

      @tweet = Tweet.new(message: Tweet.create_full_message(params))

      if @tweet.save
         @tweet.delay.tweet
         @tweet = Tweet.new

         render action: 'new'
      else
         @tweet.message = params[:tweet][:message]
         render action: 'new'
      end
   end

   def index
   end
end
