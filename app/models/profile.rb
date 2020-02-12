class Profile < ApplicationRecord
  belongs_to :user, optional: true
  validates :tell_number, presence: true
end
