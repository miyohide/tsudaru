# coding: utf-8
class TweetsController < ApplicationController
   def new
      @tweet = Tweet.new
      @delayed_jobs = DelayedJob.order("created_at DESC").limit(5)
   end

   def create
     # 次のツイートの時にでも使う項目を設定
      @speaker = params[:tweet][:speaker]
      @hashtag = params[:tweet][:hashtag]

      @tweet = Tweet.new(params[:tweet])

      if @tweet.save
         @tweet.delay.tweet

         @tweet = Tweet.new
         @delayed_jobs = DelayedJob.order("created_at DESC").limit(5)

         render action: 'new'
      else
         @tweet.message = params[:tweet][:message]
         render action: 'new'
      end
   end

   def index
   end
end
