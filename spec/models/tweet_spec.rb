# coding: utf-8
require 'spec_helper'

describe Tweet do
  describe "#tweet" do
    let(:tweet) { Tweet.new(message: "foobar", hashtag: "#hashtag", speaker: "speaker") }
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

  describe "#tweet_message_less_than_140" do
    context "(tweet message).length > 140" do
      subject(:tweet) { Tweet.new(message: "a" * 137, speaker: "b", hashtag: "c") }
      it "raise validation error" do
        expect(tweet.valid?).to be_falsey
        expect(tweet.errors.messages).to have_key(:message)
      end
    end

    context "(tweet message).length <= 140" do
      subject(:tweet) { Tweet.new(message: "a" * 136, speaker: "b", hashtag: "c") }
      it "raise validation error" do
        expect(tweet.valid?).to be_truthy
      end
    end
  end
end
