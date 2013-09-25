# coding: utf-8
class TweetsController < ApplicationController
   def new
      @tweet = Tweet.new
   end

   def create
      @speaker = params[:tweet_opt][:speaker]
      @hashtag = params[:tweet_opt][:hashtag]
      message = "#{@speaker}「" + params[:tweet][:message] + "」 #{@hashtag}"

      @tweet = Tweet.new(message: message)

      if @tweet.save
         @tweet = Tweet.new
         render action: 'new'
      else
         render action: 'new'
      end
   end

   def index
   end
end
