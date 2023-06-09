class CreateCoupons < ActiveRecord::Migration[7.0]
  def change
    create_table :coupons do |t|
      t.string :name
      t.string :code, unique: true
      t.float :percent_off
      t.float :dollar_off
      t.boolean :active, default: false
      t.references :merchant, foreign_key: true

      t.timestamps
    end

    add_reference :invoices, :coupon, foreign_key: true, optional: true
  end
end