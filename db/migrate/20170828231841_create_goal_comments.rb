class CreateGoalComments < ActiveRecord::Migration[5.1]
  def change
    create_table :goal_comments do |t|
      t.text "body", null: false
      t.integer "author_id", null: false

      t.timestamps
    end

    add_index :goal_comments, :author_id, name: "index_goal_comments_on_author_id"
  end
end
