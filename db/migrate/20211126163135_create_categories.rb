class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :forumthread_count, default: 0

      t.timestamps
    end

    add_column :forumthreads, :category_id, :integer

    add_foreign_key :forumthreads, :categories, foreign_key: true
  end
end
