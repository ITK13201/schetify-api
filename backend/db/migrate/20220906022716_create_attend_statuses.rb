class CreateAttendStatuses < ActiveRecord::Migration[7.0]
  def change
    create_table :attend_statuses do |t|
      t.string :user_id, null: false, limit: 36
      t.bigint :schedule_candidate_id, null: false
      t.integer :status, null: false
      t.timestamps
    end
    add_foreign_key :attend_statuses, :users, column: :user_id, on_delete: :cascade
    add_foreign_key :attend_statuses, :schedule_candidates, column: :schedule_candidate_id, on_delete: :cascade
  end
end
