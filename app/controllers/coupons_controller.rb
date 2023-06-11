class CouponsController < ApplicationController

  def new
    merchant
    @coupon_new = merchant.coupons.new
  end

  def create
    coupon = Coupon.new(coupon_params)

    if coupon.save
      require 'pry'; binding.pry
      redirect_to merchant_coupons_path(merchant)
    else
      redirect_to new_merchant_coupon_path(merchant)
    end
  end

  def show
    @coupon = Coupon.find(params[:id])
  end

  def update
    coupon = Coupon.find(params[:id])
    if coupon.update(active_params)
      redirect_to merchant_coupon_path(merchant, coupon)
    else
      render :show
    end
  end

  private

  def merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def active_params
    params.require(:coupon).permit(:active)
  end

  def coupon_params
    params.require(:coupon).permit(:name, :code, :amount, :amount_type, :merchant_id, :active)
  end
end

