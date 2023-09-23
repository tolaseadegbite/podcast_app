class CreateSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :subscribable, polymorphic: true, null: false

      t.timestamps
    end

    add_index :subscriptions, [:user_id, :subscribable_id, :subscribable_type], unique: true, name: 'user_subscribable_index'
    add_index :subscriptions, [:subscribable_id, :subscribable_type]
  end
end-
