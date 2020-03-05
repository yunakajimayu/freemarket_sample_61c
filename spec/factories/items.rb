FactoryBot.define do
  factory :item, class: Item do |i|
    
    i.name { "くらげ" }
    i.description { "くらげです\nくらげたちです" }
    i.price { 1000 }
    i.size { 0 }
    i.status { "0" }
    i.condition { 1 }
    i.seller_id {1}
    i.buyer_id {nil}
    i.pictures { "spec/fixtures/testsample.jpg" }
    i.pictures { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/testsample.jpg'), 'image/jpeg') }
    association :category, factory: :category
  end
end