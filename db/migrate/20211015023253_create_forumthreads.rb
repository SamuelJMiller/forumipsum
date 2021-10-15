class CreateForumthreads < ActiveRecord::Migration[6.0]
  def change
    create_table :forumthreads do |t|
      t.string :title
      t.integer :replycount

      t.timestamps
    end
  end
end
