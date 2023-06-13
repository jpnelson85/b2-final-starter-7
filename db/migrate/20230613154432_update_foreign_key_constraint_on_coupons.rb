class UpdateForeignKeyConstraintOnCoupons < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :coupons, :merchants
    add_foreign_key :coupons, :merchants, on_delete: :cascade
  end
end
