class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.datetime :start_at
      t.datetime :end_at
      t.string :image_url
      t.string :location_name
      t.string :location_address
      t.float :location_latitude
      t.float :location_longitude
      t.integer :group_num
      t.integer :total_cost
      t.string :questionnaire_url
      t.integer :pattern
      t.timestamps
    end
    add_index :events, :name, unique: true
  end
end
