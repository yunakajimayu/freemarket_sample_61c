FactoryBot.define do
  factory :item, class: Item do |i|
    i.name { "テスト商品名" }
    i.description { "テスト\nテスト商品説明" }
    i.pictures { [ Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/testsample.jpg'), 'spec/fixtures/testsample.jpg') ] }
    i.price { 1000 }
    i.condition { :new_unused }
    i.size { 0 }
    i.status { 0 }
    i.seller_id {1}
    i.buyer_id {nil}
    trait :with_picture do
      pictures { [ File.new("#{Rails.root}/spec/fixtures/testsample.jpg")]  }
    end
    association :category #関連するデータを同時に作成する
    association :delivery
  end
end