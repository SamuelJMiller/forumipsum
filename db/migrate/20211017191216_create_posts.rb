class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.integer :thread_id
      t.text :body
      t.integer :feedback_score
      t.boolean :is_banned

      t.timestamps
    end

    add_column :forumthreads, :is_banned, :boolean, default: false
  end
end
