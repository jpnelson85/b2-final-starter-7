class Coupon < ApplicationRecord
  validates_presence_of :name, :code
  validates_uniqueness_of :code
  validate :validate_max_activated_coupons, on: :create
  belongs_to :merchant
  has_many :invoices

  enum amount_type: { "percent": 0, "dollar": 1 }

  def count_successful_coupons
    invoices.joins(:transactions).where("invoices.status = ? AND transactions.result = ?", 2, 1).count
  end

  def validate_max_activated_coupons
    return unless active?

    if merchant.coupons.active.count >= 5
      errors.add(:base, "Merchant can have a maximum of 5 activated coupons")
    end
  end
end