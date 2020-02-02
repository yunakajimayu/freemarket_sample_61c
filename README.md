# freemarket_sample_61c DB設計
<!-- Gemfile "ancestry"を使用することで、categoryとitemのような多対多の関係であっても中間テーブルを省略することが可能なのではないかと考えています。 -->
## Usersテーブル
|Colimn|Type|Options|
|------|----|-------|
|email|string|null: false|
|password|string|null: false|
|birthyear|date|null: false|
|birthmonth|date|null: false|
|birthday|date|null:false|
<!-- |sns_credential|reference|foreign_key: true| -->
### Association
- has_many: comments
- has_many: items
- has_one: address
- has_many: credits
- has_one: authrization
- has_many: likes
- has_many: sns_credentials
- has_one: profile
- has_one: authorization

## profileテーブル
|Colimn|Type|Options|
|------|----|-------|
|user_id|reference|null: false, foreign_key: true|
|profile|text||
|profile_image|string||
|nickname|string|null: false|
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_kana|string|null: false|
|last_name_kana|string|null: false|
|tel_number|integer|null: false, unique: true|
### Association
- belongs_to: user

## SnsCredentialテーブル
|Colimn|Type|Options|
|------|----|-------|
|user_id|reference|null: false|
|uid|string|null: false|
|provider|string|null: false|
### Association
- belongs_to: user

## Addressテーブル
|Colimn|Type|Options|
|------|----|-------|
|zipcode|string|null: false|
|prefecture_id|integer|null: false|
|city|string|null: false|
|address|string|null: false|
|address_building|string||
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_kana|string|null: false|
|last_name_kana|string|null: false|
### Association
- belongs_to: user

## Authrizationsテーブル
|Colimn|Type|Options|
|------|----|-------|
|user_id|reference|null: false, foreign_key: true|
|authrization_number|integer|null: false|
### Association
- belongs_to: user

## Itemsテーブル
|Colimn|Type|Options|
|------|----|-------|
|name|string|null: false, add_index|
|description|text|null: false|
|prefecture|string|null: false|
|price|integer|null: false|
|postage|integer|null: false|
|size|integer|null: false|
|status|string|null: false|
|dalivery|reference|null: false, foreign_key: true|
|picture|string|null: false|
|saler_id|reference|null: false, foreign_key: true, class:User|
|buyer_id|reference|foreign_key: true, class: User|
|like|reference|foreign_key: true|
|user_rating|reference|null: false, foreign_key: true|
|condition|integer|null: false|
|category_id|reference|foreign_key: true, null: false|
### Association
- belongs_to: category
- belongs_to: user
- has_many: comments
- belongs_to: delivery
- has_one: user_rating
- has_many: likes

## Creditsテーブル
|Colimn|Type|Options|
|------|----|-------|
|user|reference|null: false|
|card_id|integer|null: false|
|limit_month|date|null: false|
|limit_year|date|null: false|
|security_code|integer|null: false|
### Association
- belongs_to: user

## Commentsテーブル
|Colimn|Type|Options|
|------|----|-------|
|message|text|null: false|
|user|reference|null: false, foreugn_key: true|
|item|reference|null: false, foreugn_key: true|
### Association
- belongs_to: user
- belongs_to: item

## Categoriesテーブル
|Colimn|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string||
### Association
- has_many: items
- has_ancestry

## Deliverysテーブル
|Colimn|Type|Options|
|------|----|-------|
|delivery_day|date|null: false|
|delivery_status|string|null: false|
### Association
- has_many: items

## UserRatingテーブル
|Colimn|Type|Options|
|------|----|-------|
|rating_by_saler|integer|null: false|
|rating_by_buyer|integer|null: false|
|item_id|reference|null: false|
### Association
- belongs_to: item

## Likesテーブル
|Colimn|Type|Options|
|------|----|-------|
|like_count|string||
|user_id|string|null: false, foreign_key: true|
|item_id|string|null: false, foreign_key: true|
### Association
- belongs_to: user
- belongs_to: item

<!-- Usersテーブルにnickname, kana_name,をprofileテーブルから移動させる -->






