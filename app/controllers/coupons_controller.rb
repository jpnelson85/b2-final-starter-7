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
    if @coupon.valid?
      @coupon.save
      redirect_to merchant_coupons_path(@merchant)
    else
      redirect_to new_merchant_coupon_path(@merchant)
      flash.notice =  "Coupon code must be unique"
    end
  end

  def update
    @coupon.update(active_params)
    redirect_to merchant_coupon_path(@merchant, @coupon)
  end

  

  private

  def merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def merchant_coupon
    @merchant = Merchant.find(params[:merchant_id])
    @coupon = Coupon.find(params[:id])
  end

  def active_params
    params.require(:coupon).permit(:active)
  end

  def coupon_params
    params.permit(:name, :code, :amount, :amount_type)
  end
end

