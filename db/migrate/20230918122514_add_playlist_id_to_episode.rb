class AddPlaylistIdToEpisode < ActiveRecord::Migration[7.0]
  def change
    add_reference :episodes, :playlist, foreign_key: true
  end
end
