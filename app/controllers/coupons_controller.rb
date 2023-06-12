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
    @coupon = Coupon.new(coupon_params)
    @coupon.merchant_id = params[:merchant_id]
    if @coupon.valid? && !@coupon.validate_max_activated_coupons(params[:merchant_id])
      @coupon.save
      redirect_to merchant_coupons_path(@merchant)
    elsif @coupon.validate_max_activated_coupons(params[:merchant_id])
      redirect_to new_merchant_coupon_path(@merchant)
      flash.message = "Merchant can have a maximum of 5 activated coupons"
    else
      redirect_to new_merchant_coupon_path(@merchant)
      flash.notice =  "Coupon code must be unique"
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

