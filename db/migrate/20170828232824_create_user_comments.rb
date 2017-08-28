class CreateUserComments < ActiveRecord::Migration[5.1]
  def change
    create_table :user_comments do |t|
      t.text "body", null: false
      t.integer "author_id", null: false

      t.timestamps
    end

    add_index :user_comments, :author_id, name: "index_user_comments_on_author_id"
  end
end
