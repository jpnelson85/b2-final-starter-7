class Coupon < ApplicationRecord
  validates_presence_of :name, :code, :amount, :amount_type
  validates_uniqueness_of :code
  belongs_to :merchant
  has_many :invoices

  enum amount_type: { "percent": 0, "dollar": 1 }

  def count_successful_coupons
    invoices.joins(:transactions).where("invoices.status = ? AND transactions.result = ?", 2, 1).count
  end

  def validate_max_activated_coupons(merchant_id)
    return unless active?
    count_coupons = Merchant.find(merchant_id)
    if count_coupons.coupons.where(:active == true).count >= 5
    end
  end


end