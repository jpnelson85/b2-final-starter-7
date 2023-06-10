require "rails_helper"

RSpec.describe "coupon index page" do
  before :each do
    @merchant1 = Merchant.create!(name: "Hair Care")

    @customer_1 = Customer.create!(first_name: "Joey", last_name: "Smith")
    @customer_2 = Customer.create!(first_name: "Cecilia", last_name: "Jones")
    @customer_3 = Customer.create!(first_name: "Mariah", last_name: "Carrey")
    @customer_4 = Customer.create!(first_name: "Leigh Ann", last_name: "Bron")
    @customer_5 = Customer.create!(first_name: "Sylvester", last_name: "Nader")
    @customer_6 = Customer.create!(first_name: "Herber", last_name: "Kuhn")

    @coupon_1 = Coupon.create!(name: "10% off", code: "10percent", amount: 10, amount_type: 0, merchant_id: @merchant1.id)
    @coupon_2 = Coupon.create!(name: "$10 dollars off", code: "20dollars", amount: 20, amount_type: 1, merchant_id: @merchant1.id)
    @coupon_3 = Coupon.create!(name: "50% off", code: "50percent", amount: 50, amount_type: 0, merchant_id: @merchant1.id)

    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2)
    @invoice_2 = Invoice.create!(customer_id: @customer_1.id, status: 2)
    @invoice_3 = Invoice.create!(customer_id: @customer_2.id, status: 2, coupon_id: @coupon_1.id)
    @invoice_4 = Invoice.create!(customer_id: @customer_3.id, status: 2, coupon_id: @coupon_1.id)
    @invoice_5 = Invoice.create!(customer_id: @customer_4.id, status: 2)
    @invoice_6 = Invoice.create!(customer_id: @customer_5.id, status: 2)
    @invoice_7 = Invoice.create!(customer_id: @customer_6.id, status: 1)

    @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id)
    @item_2 = Item.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 8, merchant_id: @merchant1.id)
    @item_3 = Item.create!(name: "Brush", description: "This takes out tangles", unit_price: 5, merchant_id: @merchant1.id)
    @item_4 = Item.create!(name: "Hair tie", description: "This holds up your hair", unit_price: 1, merchant_id: @merchant1.id)

    @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 0)
    @ii_2 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 1, unit_price: 8, status: 0)
    @ii_3 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_3.id, quantity: 1, unit_price: 5, status: 2)
    @ii_4 = InvoiceItem.create!(invoice_id: @invoice_3.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)
    @ii_5 = InvoiceItem.create!(invoice_id: @invoice_4.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)
    @ii_6 = InvoiceItem.create!(invoice_id: @invoice_5.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)
    @ii_7 = InvoiceItem.create!(invoice_id: @invoice_6.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)

    @transaction1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_1.id)
    @transaction2 = Transaction.create!(credit_card_number: 230948, result: 1, invoice_id: @invoice_3.id)
    @transaction3 = Transaction.create!(credit_card_number: 234092, result: 1, invoice_id: @invoice_4.id)
    @transaction4 = Transaction.create!(credit_card_number: 230429, result: 1, invoice_id: @invoice_5.id)
    @transaction5 = Transaction.create!(credit_card_number: 102938, result: 1, invoice_id: @invoice_6.id)
    @transaction6 = Transaction.create!(credit_card_number: 879799, result: 1, invoice_id: @invoice_7.id)
    @transaction7 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_2.id)
  end

  it 'shows the coupon name, code, amount, amount_type, and status' do
    visit merchant_coupon_path(@merchant1, @coupon_1)

    expect(page).to have_content("Coupon Name #{@coupon_1.name}")
    expect(page).to have_content("Coupon Code #{@coupon_1.code}")
    expect(page).to have_content("Coupon Amount #{@coupon_1.amount}")
    expect(page).to have_content("Coupon Amount Type #{@coupon_1.amount_type}")
    expect(page).to have_content("Coupon Active #{@coupon_1.active}")
    expect(page).to_not have_content("Coupon Name #{@coupon_2.name}")
    expect(page).to_not have_content("Coupon Code #{@coupon_2.code}")
    expect(page).to_not have_content("Coupon Amount #{@coupon_2.amount}")
    expect(page).to_not have_content("Coupon Amount Type #{@coupon_2.amount_type}")
  end

  it 'shows how many times the coupon has been used succesfully' do 
    visit merchant_coupon_path(@merchant1, @coupon_1)

    expect(page).to have_content("Coupon Count Successful #{@coupon_1.count_successful_coupons}")
    expect(page).to_not have_content("Coupon Count Successful #{@coupon_2.count_successful_coupons}")
  end
end