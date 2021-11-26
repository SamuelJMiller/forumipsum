class AddCategoryToForumthreads < ActiveRecord::Migration[6.0]
  def change
    add_column :forumthreads, :category, :string, default: "Uncategorized"
  end
end
