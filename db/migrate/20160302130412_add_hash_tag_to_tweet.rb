class AddHashTagToTweet < ActiveRecord::Migration
  def change
    add_column :tweets, :hashtag, :string
  end
end
