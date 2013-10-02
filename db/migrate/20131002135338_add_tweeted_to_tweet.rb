class AddTweetedToTweet < ActiveRecord::Migration
  def change
    add_column :tweets, :tweeted, :boolean
  end
end
