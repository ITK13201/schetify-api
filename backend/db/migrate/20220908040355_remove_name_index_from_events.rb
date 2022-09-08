class RemoveNameIndexFromEvents < ActiveRecord::Migration[7.0]
  def up
    remove_index :events, :name
  end

  def down
    add_index :events, :name, unique: true
  end
end
