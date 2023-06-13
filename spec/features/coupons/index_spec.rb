require "rails_helper"

RSpec.describe "coupon index page" do
  before :each do
    @merchant1 = Merchant.create!(name: "Hair Care")
  
    @coupon1 = @merchant1.coupons.create!(name: "10% off", code: "10percent", amount: 10, amount_type: 0)
    @coupon2 = @merchant1.coupons.create!(name: "$10 dollars off", code: "10dollars", amount: 10, amount_type: 1)
    @coupon3 = @merchant1.coupons.create!(name: "50% off", code: "50percent", amount: 50, amount_type: 0)
    @coupon4 = @merchant1.coupons.create!(name: "$5 dollars off", code: "5dollars", amount: 5, amount_type: 1, active: false)
  end

  it "display all coupons after clicking link in merchant dashboard" do
    visit merchant_dashboard_index_path(@merchant1)

    expect(page).to have_link("View All Coupons")

    click_link ("View All Coupons")

    expect(current_path).to eq(merchant_coupons_path(@merchant1))
  end

  it "displays all coupon names and the amount off" do
    visit merchant_coupons_path(@merchant1)

    within("#coupon_details") do
      expect(page).to have_content("Coupon Name #{@coupon1.name}")
      expect(page).to have_content("Percentage Amount Off #{@coupon1.amount}")
      expect(page).to have_content("Coupon Name #{@coupon2.name}")
      expect(page).to have_content("Dollar Amount Off $#{@coupon2.amount}")
    end
  end

  it "each coupon name is a link to that coupon show page" do
    visit merchant_coupons_path(@merchant1)

    expect(page).to have_link("#{@coupon1.name}")

    click_link "#{@coupon1.name}"
    
    expect(current_path).to eq(merchant_coupon_path(@merchant1, @coupon1))
  end

  it "display link to create new coupon that takes you to new coupon form" do
    visit merchant_coupons_path(@merchant1)

    expect(page).to have_link("Create New Coupon")

    click_link ("Create New Coupon")

    expect(current_path).to eq(new_merchant_coupon_path(@merchant1))
  end

  it "coupons are separated between active and inactive" do
    visit merchant_coupons_path(@merchant1)

    within("#active_coupons") do
      expect(page).to have_content("Active Coupons")
      expect(page).to have_content(@coupon1.name)
      expect(page).to_not have_content(@coupon4.name)
    end
    
    within("#inactive_coupons") do
      expect(page).to have_content("Inactive Coupons")
      expect(page).to have_content(@coupon4.name)
      expect(page).to_not have_content(@coupon1.name)
    end
  end

  it 'has header of upcoming holidays' do
    visit merchant_coupons_path(@merchant1)

    expect(page).to have_content("Upcoming Holidays")
  end 

  # sad path 2
  it 'has name and date of next 3 upcoming holidays' do
    visit merchant_coupons_path(@merchant1)

    expect(page).to have_content("Upcoming Holidays")
    expect(page).to have_content("Juneteenth")
    expect(page).to have_content("2023-06-19")
    expect(page).to have_content("Independence Day")
    expect(page).to have_content("2023-07-04")
    expect(page).to have_content("Labour Day")
    expect(page).to have_content("2023-09-04")
    expect(page).to_not have_content("Christmas")
    expect(page).to_not have_content("2023-12-25")
  end
end