class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: false do |t|
      t.string :id, null: false, limit: 36, primary_key: true
      t.string :username, null: false, limit: 255
      t.string :email, limit: 255
      t.string :firebase_id, null: false, limit: 255
      t.string :twitter_id, limit: 255
      t.string :google_id, limit: 255
      t.timestamps
    end
    add_index :users, :username, unique: true
    add_index :users, :email, unique: true
    add_index :users, :firebase_id, unique: true
    add_index :users, :twitter_id, unique: true
    add_index :users, :google_id, unique: true
  end
end
