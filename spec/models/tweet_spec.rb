# coding: utf-8
require 'spec_helper'

describe Tweet do
   describe 'Validations' do
      it { should ensure_length_of(:message).is_at_most(140) }
   end

   describe '.create_full_message' do
      let(:params) { { tweet_opt: { speaker: "speaker", hashtag: "#hashtag" }, tweet: { message: "message" } } }
      context 'all parameters fill' do
         it { expect(Tweet.create_full_message(params)).to eq "speaker「message」 #hashtag" }
      end
   end
end
