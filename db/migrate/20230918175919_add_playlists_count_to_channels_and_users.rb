class AddPlaylistsCountToChannelsAndUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :channels, :playlists_count, :integer, null: false, default: 0
    add_column :users, :playlists_count, :integer, null: false, default: 0
  end
end
