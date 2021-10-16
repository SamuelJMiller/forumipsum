class EditUserFields < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :username, :string, null: false
    change_column :users, :is_banned, :boolean, default: false
    change_column :users, :post_count, :integer, default: 0
  end
end
