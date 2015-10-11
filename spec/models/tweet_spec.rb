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
      before do
        Twitter.stub(:update)
        tweet.tweet
      end
      it { tweet.tweeted.should eq true }
    end
    # ツイートが失敗したが、返ってきたエラーが重複エラーだった場合
    context "tweet fail because duplicate error." do
      before do
        Twitter.stub(:update).and_raise(Twitter::Error::Forbidden, "Status is a duplicate")
        tweet.tweet
      end

      it { tweet.tweeted.should eq true }
    end
    # ツイートが失敗し、返ってきたエラーが重複エラーでなかった場合
    context "tweet fail because does not duplicate error." do
      before do
        Twitter.stub(:update).and_raise(Twitter::Error::Forbidden, "Status is a foobar")
      end

      it { expect { tweet.tweet }.to raise_error(Twitter::Error::Forbidden, "Status is a foobar") }
    end
  end
end
