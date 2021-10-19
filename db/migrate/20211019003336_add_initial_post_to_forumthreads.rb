class AddInitialPostToForumthreads < ActiveRecord::Migration[6.0]
  def change
    add_column :forumthreads, :initial_post, :text
  end
end
