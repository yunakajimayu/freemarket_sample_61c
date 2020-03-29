class Item < ApplicationRecord
  belongs_to :category
  belongs_to :user, foreign_key: "seller_id"
  has_many :comments
  has_one :delivery, dependent: :destroy
  has_one :user_rating
  has_many :likes
  mount_uploaders :pictures, PicturesUploader
  serialize :pictures, JSON

  
  accepts_nested_attributes_for :delivery, allow_destroy: true
  validates :name,presence: true,length: { maximum: 40 }
  validates :description,presence: true, length: { maximum: 1000 }
  validates :price,presence: true,numericality: { only_integer: true }
  validates :condition,presence: true
  validates :category_id,presence: true
  validates :pictures,presence: true
  validates :size,presence: true
  validate :image_length #カスタムメソッドを使用する際は単数形のvalidateを使用する
  validate :price_range


  enum condition: {
    新品、未使用: 0, 
    未使用に近い: 1, 
    目立った傷や汚れなし: 2, 
    やや傷や汚れあり: 3, 
    傷や汚れあり: 4, 
    全体的に状態が悪い: 5
}

  def image_length
    # バリデーションのカスタムメソッド
    # 画像が10枚以上は無効とする
    if pictures.length > 10
      errors.add(:pictures, :image_length)
      # :image_lengthにはエラー文が格納されている(ja.ymlで定義済み)
    end
  end

  def price_range
    if price.to_i < 300 || price.to_i > 9999999
      errors.add(:price, :price_range)
    end
  end

end