class CreateScheduleCandidates < ActiveRecord::Migration[7.0]
  def change
    create_table :schedule_candidates do |t|
      t.bigint :event_id, null: false
      t.datetime :start_at, null: false
      t.datetime :end_at, null: false
      t.timestamps
    end
    add_foreign_key :schedule_candidates, :events, column: :event_id, on_delete: :cascade
  end
end
