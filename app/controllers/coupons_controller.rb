class CouponsController < ApplicationController
  before_action :set_merchant

  def new
    @coupon = @merchant.coupons.new
  end

  def create
    @coupon = @merchant.coupons.new(coupon_params)

    if @coupon.save
      redirect_to merchant_coupons_path(@merchant)
    else
      render :new
    end
  end

  def show
    @coupon = @merchant.coupons.find(params[:id])
  end

  private

  def set_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def coupon_params
    params.require(:coupon).permit(:name, :code, :amount, :amount_type)
  end
end