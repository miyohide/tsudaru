# coding: utf-8
require 'spec_helper'

describe Tweet do
  describe 'Validations' do
    it { should ensure_length_of(:message).is_at_most(140) }
  end

  describe "self.create_full_message" do
    let(:params) { {tweet_opt: {speaker: "speaker", hashtag: "#hashtag"}, tweet: {message: "message"} } }
    it "return message" do
      Tweet.create_full_message(params).should eq("speaker「message」 #hashtag")
    end
  end

  describe "tweet" do
    let(:tweet) { Tweet.new(message: "foobar") }
    # ツイートが成功した場合
    context "tweet success" do
      it "tweeted flag is true" do
        allow_any_instance_of(TwitterAPI).to receive_message_chain(:client, :update)
        tweet.tweet
        expect(tweet.reload.tweeted).to be_truthy
      end
    end
    # ツイートが失敗したが、返ってきたエラーが重複エラーだった場合
    context "tweet fail because duplicate error." do
      it "tweted flag is true" do
        allow_any_instance_of(TwitterAPI).to receive_message_chain(:client, :update).and_raise(Twitter::Error.new("Message", nil, Twitter::Error::DuplicateStatus))
        tweet.tweet
        expect(tweet.reload.tweeted).to be_truthy
      end
    end
    # ツイートが失敗し、返ってきたエラーが重複エラーでなかった場合
    context "tweet fail because does not duplicate error." do
      it "raise Twitter::Error" do
        allow_any_instance_of(TwitterAPI).to receive_message_chain(:client, :update).and_raise(Twitter::Error.new("Message", nil, Twitter::Error::TooManyRequests))
        expect{tweet.tweet}.to raise_error(Twitter::Error)
      end
    end
  end
end
