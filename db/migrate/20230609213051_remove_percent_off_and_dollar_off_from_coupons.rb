class RemovePercentOffAndDollarOffFromCoupons < ActiveRecord::Migration[7.0]
  def change
    remove_column :coupons, :percent_off, :integer
    remove_column :coupons, :dollar_off, :integer
  end
end
