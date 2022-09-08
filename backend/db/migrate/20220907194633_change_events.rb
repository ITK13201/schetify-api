class ChangeEvents < ActiveRecord::Migration[7.0]
  def up
    rename_column :events, :total_cost, :cost
    add_column :events, :cost_type, :integer, null: false, default: 0
    add_column :events, :description, :text
  end

  def down
    rename_column :events, :cost, :total_cost
    remove_column :events, :cost_type
    remove_column :events, :description
  end
end
