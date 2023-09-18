class RemoveChannelIdFromPlaylists < ActiveRecord::Migration[7.0]
  def change
    remove_column :playlists, :channel_id, :integer
  end
end
