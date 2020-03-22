class Item < ApplicationRecord
  belongs_to :category
  belongs_to :user, foreign_key: "seller_id"
  has_many :comments
  has_one :delivery, dependent: :destroy
  has_one :user_rating
  has_many :likes
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
  validate :image_length #カスタムメソッドを使用する際は単数形のvalidateを使用する
  validate :price_range


  enum condition: [
    :new_unused, 
    :almost_unused, 
    :no_noticeable_scratches_or_dirt, 
    :some_scratches_and_dirt, 
    :there_are_scratches_and_dirt, 
    :overall_bad_condition
  ]

  def image_length
    # バリデーションのカスタムメソッド
    # 画像が10枚以上は無効とする
    if pictures.length > 10
      errors.add(:pictures, :image_length)
      # :image_lengthにはエラー文が格納されている(ja.ymlで定義済み)
    end
  end

  def price_range
    if price < 300 || price > 9999999
      errors.add(:price, :price_range)
    end
  end

end