class AddColumnsToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :completed, :string
    add_column :goals, :privacy, :string
  end
end
