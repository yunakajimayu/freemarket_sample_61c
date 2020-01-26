# freemarket_sample_61c DB設計
<!-- Gemfile "ancestry"を使用することで、categoryとitemのような多対多の関係であっても中間テーブルを省略することが可能なのではないかと考えています。 -->
## Usersテーブル
|Colimn|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_kana|string|null: false|
|last_name_kana|string|null: false|
|email|string|null: false|
|password|string|null: false|
|birthday_year|date|null: false|
|birthday_month|date|null: false|
|birthday_day|date|null:false|
|profile|text||
|profile_image|string||
|tel|reference|null: false, foreign_key: true|
|address|reference|null: false, foreign_key: true|
|comment|reference|foreign_key: true|
### Association
- has_many: comments
- has_many: items
- has_one: address
- has_many: credits
- has_one: tel
- has_many: user_ratings

## Addressテーブル
|Colimn|Type|Options|
|------|----|-------|
|zipcode|string|null: false|
|prefecture_id|integer|null: false|
|city|string|null: false|
|address|string|null: false|
|address_building|string||
### Association
- belongs_to: user

## Telsテーブル
|Colimn|Type|Options|
|------|----|-------|
|user|reference|null: false, foreign_key: true|
|tel_number|integer|null: false|
|authrization_num|integer|null: false|
### Association
- belongs_to: user

## Itemsテーブル
|Colimn|Type|Options|
|------|----|-------|
|user|reference|null: false, foreign_key: true|
|name|string|null: false, add_index|
|category|reference|null: false, foreign_key: true|
|brand|string|null: false|
|condition|reference|null: false, foreign_key: true|
|comment|reference|null: false, foreign_key: true|
|description|text|null: false|
|prefecture|string|null: false|
|price|integer|null: false|
|postage|reference|null: false, foreugn_key: true|
|size|reference|null: false, foreugn_key: true|
|status|reference|null: false, foreugn_key: true|
|dalivery_status|reference|null: false, foreugn_key: true|
|delivery_days|reference|null: false, foreugn_key: true|
|picture|string|null: false|
### Association
- belongs_to: category
- belongs_to: user
- has_many: comments
- belongs_to: condition
- belongs_to: postage
- belongs_to: size
- belongs_to: status
- belongs_to: delivery_days
- belongs_to: delivery_status

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

## Categoryテーブル
|Colimn|Type|Options|
|------|----|-------|
|name|string|null: false|
|name_sub|string||
|name_sub_sub|string||
### Association
- has_many: items
- has_ancestry

## Sizeテーブル
|Colimn|Type|Options|
|------|----|-------|
|volume|string|null: false|
### Association
- has_many: items

## Statusテーブル
|Colimn|Type|Options|
|------|----|-------|
|sold_status|string|null: false|
### Association
- has_many: items

## Conditionテーブル
|Colimn|Type|Options|
|------|----|-------|
|quality|string|null: false|
### Association
- has_many: items

## Postageテーブル
|Colimn|Type|Options|
|------|----|-------|
|charge|integer|null: false|
### Association
- has_many: items

## DeliveryDaysテーブル
|Colimn|Type|Options|
|------|----|-------|
|arrival_day|date|null: false|
### Association
- has_many: items

## Deliverystatusテーブル
|Colimn|Type|Options|
|------|----|-------|
|status|string|null: false|
### Association
- has_many: items

## UserRatingテーブル
|Colimn|Type|Options|
|------|----|-------|
|rating|integer|null: false|
### Association
- has_many: users
- has_ancestry





