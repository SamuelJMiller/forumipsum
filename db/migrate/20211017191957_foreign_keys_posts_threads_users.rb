class ForeignKeysPostsThreadsUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :forumthread_id, :integer
    remove_column :posts, :thread_id, :integer
    
    add_foreign_key :posts, :users, foreign_key: true
    add_foreign_key :posts, :forumthreads, foreign_key: true
  end
end
