class AddReportWeightToForumthreads < ActiveRecord::Migration[6.0]
  def change
    add_column :forumthreads, :report_weight, :integer, default: 0
  end
end
