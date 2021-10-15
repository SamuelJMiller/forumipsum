class AddIsBannedToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :is_banned, :boolean
  end
end
