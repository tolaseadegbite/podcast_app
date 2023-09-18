class CreateEpisodePlaylists < ActiveRecord::Migration[7.0]
  def change
    create_table :episode_playlists do |t|
      t.references :episode, null: false, foreign_key: true
      t.references :playlist, null: false, foreign_key: true

      t.timestamps
    end
  end
end
