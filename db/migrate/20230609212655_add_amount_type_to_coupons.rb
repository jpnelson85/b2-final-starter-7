class AddAmountTypeToCoupons < ActiveRecord::Migration[7.0]
  def change
    add_column :coupons, :amount_type, :integer
  end
end
