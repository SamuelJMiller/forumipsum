class AddDefaultsForPosts < ActiveRecord::Migration[6.0]
  def change
    change_column :posts, :is_banned, :boolean, default: false
    change_column :posts, :feedback_score, :integer, default: 0
  end
end
