FactoryBot.define do
  factory :user do
    id {1}
    nickname {"hojihoji"}
    email {"hojihoji@aaa"}
    encrypted_password {"aa11111"}
    first_name {"ほじ"}
    last_name {"ほじ"}
    first_name_kana {"ホジ"}
    last_name_kana {"ホジ"}
    birth_date {"19931212"}
  end
end