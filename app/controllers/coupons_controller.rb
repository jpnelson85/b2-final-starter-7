class CouponsController < ApplicationController
before_action :merchant, only: [:index, :new, :create]
before_action :merchant_coupon, only: [:show, :edit, :update]

  def index
    @coupons = @merchant.coupons
  end

  def show
  end
  
  def new
  end

  def create
    if !merchant.five_max_active_coupons?
      Coupon.new(coupon_params)
    else
      flash[:error] = "You have reached the maximum number of active coupons"
    end
  end

  def update
    @coupon.update(status_update)
    redirect_to merchant_coupon_path(@merchant, @coupon)
  end

  private

  def status_update
    params.permit(:active)
  end

  def merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def merchant_coupon
    @merchant = Merchant.find(params[:merchant_id])
    @coupon = Coupon.find(params[:id])
  end

  def coupon_params
    params.permit(:name, :code, :amount, :amount_type)
  end
end

