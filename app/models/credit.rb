class Credit < ApplicationRecord
  belongs_to :user, optional: true
  # validates :user_id, :customer_id, :card_id, presence: true
end
