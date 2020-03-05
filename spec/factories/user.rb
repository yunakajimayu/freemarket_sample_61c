FactoryBot.define do
  factory :user do
    sequence(:nickname) { |n| "test_name#{n}" }
    sequence(:email) { |n| "test#{n}@email.com" }
    sequence(:encrypted_password) { "$2dfrdmzKsjidkslAKmdk" }
    sequence(:password) {"2dfrdmzKsjidkslAKmdk"}
    sequence(:first_name) { "太郎" }
    sequence(:last_name) { "田中" }
    sequence(:first_name_kana) { "タロウ" }
    sequence(:last_name_kana) { "タナカ" }
    sequence(:birth_date) { "1980-01-01" }
  end

  
end
