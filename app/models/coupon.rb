class Coupon < ApplicationRecord
  validates_presence_of :name, :code
  validates_uniqueness_of :code
  belongs_to :merchant
  has_many :invoices

  enum amount_type: { "percent": 0, "dollar": 1 }

end