class AddUserIdToForumthreads < ActiveRecord::Migration[6.0]
  def change
    add_column :forumthreads, :user_id, :integer
    add_foreign_key :forumthreads, :users, foreign_key: true
  end
end
