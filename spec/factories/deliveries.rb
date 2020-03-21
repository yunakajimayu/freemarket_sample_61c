FactoryBot.define do
  factory :delivery do
    delivery_day { 1 }
    delivery_status { "MyString" }
    delivery_method { 1 }
    postage { 1 }
    postage { 1 }
    postage_bearer { 1 }
    item_id { "" }
    delivery_area { 1 }
  end
end
