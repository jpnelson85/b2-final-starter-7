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
    @coupon = @merchant.coupons.new(coupon_params)
    if @merchant.five_max_active_coupons
      redirect_to new_merchant_coupon_path(@merchant)
      flash.notice = "Merchant can have a maximum of 5 activated coupons"
    elsif @coupon.invalid?
      redirect_to new_merchant_coupon_path(@merchant)
      flash.notice =  "Coupon code must be unique"
    else
      @coupon.save
      redirect_to merchant_coupons_path(@merchant)
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

