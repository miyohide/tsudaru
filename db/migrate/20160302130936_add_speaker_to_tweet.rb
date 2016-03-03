class AddSpeakerToTweet < ActiveRecord::Migration
  def change
    add_column :tweets, :speaker, :string
  end
end
