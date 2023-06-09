class Coupon < ApplicationRecord
  validates_presence_of :name, :code, :percent_off, :dollar_off
  validates_uniqueness_of :code
  belongs_to :merchant
  has_many :invoices
end