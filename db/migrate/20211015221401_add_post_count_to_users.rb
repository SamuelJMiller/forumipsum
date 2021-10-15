class AddPostCountToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :post_count, :integer
  end
end
