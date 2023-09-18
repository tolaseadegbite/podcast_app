class RemovePlaylistIdFromEpisodes < ActiveRecord::Migration[7.0]
  def change
    remove_column :episodes, :playlist_id, :integer
  end
end
