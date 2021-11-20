class AddReportWeightToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :report_weight, :integer, default: 0
  end
end
