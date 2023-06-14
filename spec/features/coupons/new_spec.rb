require "rails_helper"

RSpec.describe "coupon index page" do
  before :each do
    @merchant1 = Merchant.create!(name: "Hair Care")

    @coupon1 = Coupon.create!(name: "10% off", code: "10percent", amount: 10, amount_type: 0, merchant_id: @merchant1.id)
    @coupon2 = Coupon.create!(name: "$10 dollars off", code: "10dollars", amount: 10, amount_type: 1, merchant_id: @merchant1.id)
    @coupon3 = Coupon.create!(name: "50% off", code: "50percent", amount: 50, amount_type: 0, merchant_id: @merchant1.id)
  end

  it 'can create a new coupon' do
    visit new_merchant_coupon_path(@merchant1.id)

    fill_in 'Name', with: '30% off'
    fill_in 'Code', with: '30percent'
    fill_in 'Amount', with: 30
    select 'percent', from: 'Amount type'

    click_button ('Create Coupon')

    expect(current_path).to eq(merchant_coupons_path(@merchant1))
    expect(page).to have_content('30% off')
  end

  # sad path 1
  it 'validates uniqueness of code and displays flash message' do
    existing_code = @coupon1.code
  
    visit new_merchant_coupon_path(@merchant1)
  
    fill_in 'Name', with: 'New Coupon'
    fill_in 'Code', with: existing_code
    fill_in 'Amount', with: 20
    select 'percent', from: 'Amount type'
  
    click_button 'Create Coupon'
  
    expect(current_path).to eq(new_merchant_coupon_path(@merchant1))
    expect(page).to have_content('Coupon code must be unique')
  end
end

RSpec.describe 'flash message for max 5 activated coupons' do
  it 'flash message for max 5 activated coupons' do
    merchant1 = Merchant.create!(name: "Hair Care")

    coupon1 = Coupon.create!(name: "10% off", code: "10percent", amount: 10, amount_type: 0, merchant_id: merchant1.id, active: true)
    coupon2 = Coupon.create!(name: "$10 dollars off", code: "10dollars", amount: 10, amount_type: 1, merchant_id: merchant1.id, active: true)
    coupon3 = Coupon.create!(name: "50% off", code: "50percent", amount: 50, amount_type: 0, merchant_id: merchant1.id, active: true)
    coupon4 = Coupon.create!(name: "3% off", code: "3percent", amount: 3, amount_type: 0, merchant_id: merchant1.id, active: true)
    coupon5 = Coupon.create!(name: "5% off", code: "5percent", amount: 5, amount_type: 0, merchant_id: merchant1.id, active: true)
    
    visit new_merchant_coupon_path(merchant1)

    fill_in 'Name', with: 'New Coupon'
    fill_in 'Code', with: 'newcoupon'
    fill_in 'Amount', with: 20
    select 'percent', from: 'Amount type'

    click_button 'Create Coupon'

    expect(current_path).to eq(new_merchant_coupon_path(merchant1))
    expect(page).to have_content('Merchant can have a maximum of 5 activated coupons')
  end
end