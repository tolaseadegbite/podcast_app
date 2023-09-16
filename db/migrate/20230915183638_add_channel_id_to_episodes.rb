class AddChannelIdToEpisodes < ActiveRecord::Migration[7.0]
  def change
    add_reference :episodes, :channel, null: false, foreign_key: true
  end
end
