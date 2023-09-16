class AddIndexToChannelsName < ActiveRecord::Migration[7.0]
  def change
    add_index :channels, :name, unique: true
  end
end
