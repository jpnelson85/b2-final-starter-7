class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  belongs_to :coupon, optional: true

  enum status: [:cancelled, :in_progress, :completed]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def grand_total
    if coupon == nil 
      total_revenue
    elsif coupon.amount_type == "dollar"
      [total_revenue - coupon.amount, 0.0].max
    else  
      total_revenue - (total_revenue*(coupon.amount/100.00))
    end
  end
end
