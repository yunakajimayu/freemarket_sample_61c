# crumb パンくず名 do
#   link "パンくずとして表示させるリンク名", そのリンク先のURL
# end

crumb :root do
  link "Fmarket", root_path
end

crumb :mypage do
  link "マイページ", user_path
  parent :root
end

crumb :logout do
  link "ログアウト", logout_user_path
  parent :mypage
end

crumb :identification do
  link "本人情報の登録", identification_user_path
  parent :mypage
end

# ↓以下のパンくずはマスターにマージ後にコメントアウトを外します。

# crumb :creditcard do
#   link "支払い方法", card_user_path
#   parent :mypage
# end

# crumb :item do
#   link "商品詳細",
#   parent :root
# end