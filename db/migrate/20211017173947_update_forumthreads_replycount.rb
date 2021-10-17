class UpdateForumthreadsReplycount < ActiveRecord::Migration[6.0]
  def change
    change_column :forumthreads, :replycount, :integer, default: 0
  end
end
