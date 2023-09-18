class CreatePlaylists < ActiveRecord::Migration[7.0]
  def change
    create_table :playlists do |t|
      t.string :name
      t.text :description
      t.references :user, null: false, foreign_key: true
      t.references :channel, null: false, foreign_key: true

      t.timestamps
    end

    add_index :playlists, :name, unique: true
  end
end
