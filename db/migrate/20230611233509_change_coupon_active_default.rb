class ChangeCouponActiveDefault < ActiveRecord::Migration[7.0]
  def change
    change_column_default :coupons, :active, from: false, to: true
  end
end
