FactoryBot.define do
  factory :item, class: Item do |i|
    i.name { "テスト商品名" }

    # i.pictures { [ Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/testsample.jpg'), 'spec/fixtures/testsample.jpg') ] }
    i.description { "テスト\nテスト商品説明" }
    i.price { 1000 }
    i.size { 0 }
    i.status { "0" }
    i.condition { 1 }
    i.seller_id {1}
    i.buyer_id {nil}
    trait :with_picture do
      pictures { [ File.new("#{Rails.root}/spec/fixtures/testsample.jpg")]  }
    end
    association :category, factory: :category
  end
end