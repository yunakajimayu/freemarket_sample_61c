class Credit < ApplicationRecord
  belongs_to :user, optional: true
  validates :card_id, :limit_month, :limit_year, :security_code, presence: true
end