class RemoveCategories < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :forumthreads, :categories

    remove_column :forumthreads, :category_id

    drop_table :categories
  end
end
