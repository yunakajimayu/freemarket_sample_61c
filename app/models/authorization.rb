class Authorization < ApplicationRecord
  belongs_to :user, optional: true
  validates :authorization_number, presence: true
end
