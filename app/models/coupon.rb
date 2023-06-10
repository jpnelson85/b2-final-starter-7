class Coupon < ApplicationRecord
  validates_presence_of :name, :code
  validates_uniqueness_of :code
  belongs_to :merchant
  has_many :invoices

  enum amount_type: { "percent": 0, "dollar": 1 }

  def self.count_successful_coupons
    Invoice.find_by(coupon_id: self.id, status: 2)
  end
end