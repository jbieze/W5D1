class AddColumnToGoals < ActiveRecord::Migration[5.1]
  def change
    add_column :goals, :user_id, :string, null: false
  end
end
