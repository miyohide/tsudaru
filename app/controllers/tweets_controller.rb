# coding: utf-8
class TweetsController < ApplicationController
   def new
      djs = DelayedJob.all
      @all_delayed_job_size = djs.size
      @not_exec_delayed_job_size = djs.select { |dj| dj.failed_at.nil? }.size
      @fail_delayed_job_size = djs.select { |dj| dj.failed_at.present? }.size
      @tweet = Tweet.new
   end

   def create
      @speaker = params[:tweet_opt][:speaker]
      @hashtag = params[:tweet_opt][:hashtag]

      @tweet = Tweet.new(message: Tweet.create_full_message(params))

      if @tweet.save
         @tweet.delay.tweet

         djs = DelayedJob.all
         @all_delayed_job_size = djs.size
         @not_exec_delayed_job_size = djs.select { |dj| dj.failed_at.nil? }.size
         @fail_delayed_job_size = djs.select { |dj| dj.failed_at.present? }.size

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
