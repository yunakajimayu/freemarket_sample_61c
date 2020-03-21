class Item < ApplicationRecord
  belongs_to :category
  belongs_to :user, foreign_key: "seller_id", dependent: :destroy
  has_many :comments
  has_one :delivery, dependent: :destroy
  has_one :user_rating
  has_many :likes
  # belongs_to :seller, class_name: "User",foreign_key: "seller_id"
  # belongs_to :buyer, class_name: "User",foreign_key: "buyer_id"
  mount_uploaders :pictures, PicturesUploader
  serialize :pictures, JSON
  
  accepts_nested_attributes_for :delivery

  validates :name,presence: true,length: { maximum: 40 }
  validates :description,presence: true, length: { maximum: 1000 }
  validates :price,presence: true,numericality: { only_integer: true }
  validates :condition,presence: true
  validates :category_id,presence: true
  validates :pictures,presence: true
  validates :size,presence: true


      
  

  enum condition: [
    :new_unused, 
    :almost_unused, 
    :no_noticeable_scratches_or_dirt, 
    :some_scratches_and_dirt, 
    :there_are_scratches_and_dirt, 
    :overall_bad_condition
  ]


end