class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nickname, :first_name, :last_name, :first_name_kana, :last_name_kana, :birth_date ,presence: true
  has_one :authorization
  has_one :address
  has_one :credit
  has_one :profile
end
