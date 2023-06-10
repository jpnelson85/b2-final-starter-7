class ChangeCouponColumns < ActiveRecord::Migration[7.0]
  def change
    change_column :coupons, :percent_off, :integer
    change_column :coupons, :dollar_off, :integer
  end
end
