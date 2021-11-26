class DefaultCategoryId < ActiveRecord::Migration[6.0]
  def change
    change_column :forumthreads, :category_id, :integer, default: "Uncategorized"
  end
end
