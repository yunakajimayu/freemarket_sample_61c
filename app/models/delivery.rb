class Delivery < ApplicationRecord
  has_one :item, dependent: :destroy
end
