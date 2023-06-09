require 'rails_helper'

RSpec.describe Coupon, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :code }
    it { should validate_uniqueness_of :code }
    it { should validate_presence_of :percent_off }
    it { should validate_presence_of :dollar_off }
  end

  describe "relationships" do
    it { should belong_to :merchant }
    it { should have_many :invoices }
  end
end