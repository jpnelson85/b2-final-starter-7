require 'rails_helper'

RSpec.describe Coupon, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :code }
    it { should validate_uniqueness_of :code }
  end

  describe "relationships" do
    it { should belong_to :merchant }
    it { should have_many :invoices }
  end

  it 'count_successful_coupons' do
    merchant1 = Merchant.create!(name: 'Hair Care')
      
    item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: merchant1.id, status: 1)
    item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: merchant1.id)
      
    customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')

    coupon_1 = Coupon.create!(name: "10% off", code: "10OFF", amount: 10, amount_type: 0, merchant_id: merchant1.id)
    coupon_2 = Coupon.create!(name: "20$ off", code: "20OFF", amount: 20, amount_type: 1, merchant_id: merchant1.id)
      
    invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 2, created_at: "2012-03-27 14:54:09", coupon_id: coupon_1.id)
    invoice_2 = Invoice.create!(customer_id: customer_1.id, status: 2, created_at: "2012-03-27 14:54:09", coupon_id: coupon_2.id)
    invoice_3 = Invoice.create!(customer_id: customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
    invoice_4 = Invoice.create!(customer_id: customer_1.id, status: 2, created_at: "2012-03-27 14:54:09", coupon_id: coupon_2.id)
    invoice_5 = Invoice.create!(customer_id: customer_1.id, status: 2, created_at: "2012-03-27 14:54:09", coupon_id: coupon_1.id)

    ii_1 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 9, unit_price: 10, status: 2)
    ii_11 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_8.id, quantity: 1, unit_price: 10, status: 1)
    ii_2 = InvoiceItem.create!(invoice_id: invoice_2.id, item_id: item_1.id, quantity: 9, unit_price: 10, status: 2)
    ii_3 = InvoiceItem.create!(invoice_id: invoice_3.id, item_id: item_1.id, quantity: 9, unit_price: 10, status: 2)
    ii_4 = InvoiceItem.create!(invoice_id: invoice_4.id, item_id: item_1.id, quantity: 1, unit_price: 10, status: 2)
    ii_5 = InvoiceItem.create!(invoice_id: invoice_5.id, item_id: item_1.id, quantity: 10, unit_price: 10, status: 2)

    transaction_1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: invoice_1.id)
    transaction_2 = Transaction.create!(credit_card_number: 230948, result: 1, invoice_id: invoice_2.id)
    
    expect(coupon_1.count_successful_coupons).to eq(1)
    expect(coupon_2.count_successful_coupons).to eq(1)
    expect(coupon_1.count_successful_coupons).to_not eq(2)
  end

  it 'validate_max_activated_coupons' do
    merchant1 = Merchant.create!(name: 'Hair Care')
    merchant2 = Merchant.create!(name: 'Toe Care')
      
    item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: merchant1.id, status: 1)
    item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: merchant1.id)
      
    customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')

    coupon_1 = Coupon.create!(name: "10% off", code: "10OFF", amount: 10, amount_type: 0, merchant_id: merchant1.id, active: true)
    coupon_2 = Coupon.create!(name: "20$ off", code: "20OFF", amount: 20, amount_type: 1, merchant_id: merchant1.id, active: true)
    coupon_3 = Coupon.create!(name: "30% off", code: "30OFF", amount: 30, amount_type: 0, merchant_id: merchant1.id, active: true)
    coupon_4 = Coupon.create!(name: "40$ off", code: "40OFF", amount: 40, amount_type: 1, merchant_id: merchant1.id, active: true)
    coupon_5 = Coupon.create!(name: "50% off", code: "50OFF", amount: 50, amount_type: 0, merchant_id: merchant1.id, active: true)
    coupon_6 = Coupon.create!(name: "60$ off", code: "60OFF", amount: 60, amount_type: 1, merchant_id: merchant2.id, active: true)
    coupon_7 = Coupon.create!(name: "70% off", code: "70OFF", amount: 70, amount_type: 0, merchant_id: merchant2.id, active: true)
    
    invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 2, created_at: "2012-03-27 14:54:09", coupon_id: coupon_1.id)
    invoice_2 = Invoice.create!(customer_id: customer_1.id, status: 2, created_at: "2012-03-27 14:54:09", coupon_id: coupon_2.id)
    invoice_3 = Invoice.create!(customer_id: customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
    invoice_4 = Invoice.create!(customer_id: customer_1.id, status: 2, created_at: "2012-03-27 14:54:09", coupon_id: coupon_2.id)
    invoice_5 = Invoice.create!(customer_id: customer_1.id, status: 2, created_at: "2012-03-27 14:54:09", coupon_id: coupon_1.id)

    ii_1 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 9, unit_price: 10, status: 2)
    ii_11 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_8.id, quantity: 1, unit_price: 10, status: 1)
    ii_2 = InvoiceItem.create!(invoice_id: invoice_2.id, item_id: item_1.id, quantity: 9, unit_price: 10, status: 2)
    ii_3 = InvoiceItem.create!(invoice_id: invoice_3.id, item_id: item_1.id, quantity: 9, unit_price: 10, status: 2)
    ii_4 = InvoiceItem.create!(invoice_id: invoice_4.id, item_id: item_1.id, quantity: 1, unit_price: 10, status: 2)
    ii_5 = InvoiceItem.create!(invoice_id: invoice_5.id, item_id: item_1.id, quantity: 10, unit_price: 10, status: 2)

    transaction_1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: invoice_1.id)
    transaction_2 = Transaction.create!(credit_card_number: 230948, result: 1, invoice_id: invoice_2.id)
    
    expect(coupon_1.validate_max_activated_coupons(merchant1.id)).to eq(nil)
    expect(coupon_2.validate_max_activated_coupons(merchant2.id)).to eq(nil)
  end
end