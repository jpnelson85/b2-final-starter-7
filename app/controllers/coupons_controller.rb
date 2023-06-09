class CouponsController < ApplicationController
  
  def index
    @coupons = @merchant.coupons
  end

  def new
    @coupon = Coupon.new
  end

  def create
    @coupon = Coupon.new(coupon_params)

    if @coupon.save
      redirect_to "merchants/#{@merchant.id}/coupons"
    else
      render :new
    end
  end

  private

  def set_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def coupon_params
    params.require(:coupon).permit(:name, :code, :amount, :amount_type)
  end
end