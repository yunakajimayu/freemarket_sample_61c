class Address < ApplicationRecord
  belongs_to :user, optional: true
  validates :zipcode, :prefecture, :city, :address, :address_building, presence: true
end
