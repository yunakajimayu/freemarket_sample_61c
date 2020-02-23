class Delivery < ApplicationRecord
  belongs_to :item,optional: true

  enum delivery_day: [
    :with_in_two_days,
    :with_in_three_days,
    :with_in_one_week
]

end
