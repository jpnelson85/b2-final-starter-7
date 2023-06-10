class AddAmountToCoupons < ActiveRecord::Migration[7.0]
  def change
    add_column :coupons, :amount, :integer
  end
end
