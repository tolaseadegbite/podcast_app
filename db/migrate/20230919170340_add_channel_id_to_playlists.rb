class AddChannelIdToPlaylists < ActiveRecord::Migration[7.0]
  def change
    add_reference :playlists, :channel, foreign_key: true
  end
end
