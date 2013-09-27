# coding: utf-8
require 'spec_helper'

describe Tweet do
   describe 'Validations' do
      it { should ensure_length_of(:message).is_at_most(140) }
   end

   describe '.create_full_message' do
      let(:params) { { tweet_opt: { speaker: "speaker", hashtag: "#hashtag" }, tweet: { message: "message" } } }
      context 'all parameters are fill' do
         it { expect(Tweet.create_full_message(params)).to eq "speaker「message」 #hashtag" }
      end

      context 'speaker is empty' do
         it { params[:tweet_opt][:speaker] = ''; expect(Tweet.create_full_message(params)).to eq "「message」 #hashtag" }
      end

      context 'hashtag is empty' do
         it { params[:tweet_opt][:hashtag] = ''; expect(Tweet.create_full_message(params)).to eq "speaker「message」 " }
      end

      context 'message is empty' do
         it { params[:tweet][:message] = ''; expect(Tweet.create_full_message(params)).to eq "speaker「」 #hashtag" }
      end
   end
end
