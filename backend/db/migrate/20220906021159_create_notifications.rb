class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.bigint :event_id, null: false
      t.string :title, null: false
      t.string :contents, null: false
      t.timestamps
    end
    add_foreign_key :notifications, :events, columns: :event_id, on_delete: :cascade
  end
end
