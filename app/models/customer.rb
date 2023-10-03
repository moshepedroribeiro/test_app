class Customer < ApplicationRecord
  def full_name
    "Sr. #{self.name}"
  end
end
