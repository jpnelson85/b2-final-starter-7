require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "validations" do
    it { should validate_presence_of :status }
    it { should validate_presence_of :customer_id }
  end
  describe "relationships" do
    it { should belong_to :customer }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
    it { should have_many :transactions}
    it { should have_many :invoice_items}
    it { should belong_to(:coupon).optional }
  end
  describe "instance methods" do
    it "total_revenue" do
      merchant1 = Merchant.create!(name: 'Hair Care')
      item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: merchant1.id, status: 1)
      item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: merchant1.id)
      customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
      invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
      ii_1 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 9, unit_price: 10, status: 2)
      ii_11 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_8.id, quantity: 1, unit_price: 10, status: 1)

      expect(invoice_1.total_revenue).to eq(100)
    end

    it "grand_total method" do
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

      expect(invoice_1.grand_total).to eq(90)
      expect(invoice_2.grand_total).to eq(70.0)
      expect(invoice_3.grand_total).to eq(90.0)
      expect(invoice_4.grand_total).to eq(0.0)
      expect(invoice_5.grand_total).to eq(90.0)
    end
  end
end
