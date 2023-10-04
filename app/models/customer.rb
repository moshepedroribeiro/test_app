class Customer < ApplicationRecord
  has_many :orders

  validates :address, presence: true
  def full_name
    "Sr. #{self.name}"
  end
end
