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

    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2)
    @invoice_2 = Invoice.create!(customer_id: @customer_1.id, status: 2)
    @invoice_3 = Invoice.create!(customer_id: @customer_2.id, status: 2)
    @invoice_4 = Invoice.create!(customer_id: @customer_3.id, status: 2)
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
  
    @coupon1 = Coupon.create!(name: "10% off", code: "10percent", percent_off: 0.10, dollar_off: 0, merchant_id: @merchant1.id)
    @coupon2 = Coupon.create!(name: "$10 dollars off", code: "10dollars", percent_off: 0.0, dollar_off: 10, merchant_id: @merchant1.id)
    @coupon3 = Coupon.create!(name: "50% off", code: "50percent", percent_off: 0.50, dollar_off: 0, merchant_id: @merchant1.id)
  end

  it "display all coupons after clicking link in merchant dashboard" do
    visit merchant_dashboard_index_path(@merchant1)

    expect(page).to have_link("View All Coupons")

    click_link "View All Coupons"

    expect(current_path).to eq("/merchants/#{@merchant1.id}/coupons")
  end

  it "displays all coupon names and the amount off" do
    visit "/merchants/#{@merchant1.id}/coupons"

    expect(page).to have_content("Coupon Name - #{@coupon1.name}")
    expect(page).to have_content("Dollar Amount Off - $#{@coupon1.dollar_off}")
    expect(page).to have_content("Percentage Amount Off - #{(@coupon1.percent_off * 100).to_i}%")
  end

  it "each coupon name is a link to that coupon's show page" do
    visit "/merchants/#{@merchant1.id}/coupons"

    expect(page).to have_link("#{@coupon1.name}")

    click_link "#{@coupon1.name}"

    expect(current_path).to eq("/merchants/#{@merchant1.id}/coupons/#{@coupon1.id}")
  end

  it "display link to create new coupon that takes you to new coupon form" do
    visit "merchants/#{@merchant1.id}/coupons"

    expect(page).to have_link("Create New Coupon")

    click_link "Create New Coupon"

    expect(current_path).to eq("/merchants/#{@merchant1.id}/coupons/new")
  end
end