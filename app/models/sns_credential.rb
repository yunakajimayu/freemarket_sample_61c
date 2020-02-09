class SnsCredential < ApplicationRecord
  belongs_to :user, optional: true
  # validates :sns_auth, presence: true
end
