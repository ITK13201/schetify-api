class CreateUsersEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :users_events do |t|
      t.string :user_id, null: false, limit: 36
      t.bigint :event_id, null: false
      t.integer :label, null: false
      t.integer :group_id
      t.timestamps
    end
    add_foreign_key :users_events, :users, column: :user_id, on_delete: :cascade
    add_foreign_key :users_events, :events, column: :event_id, on_delete: :cascade
  end
end
