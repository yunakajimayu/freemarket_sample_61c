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
|birthyear|date|null: false|
|birthmonth|date|null: false|
|birthday|date|null:false|
|profile|text||
|profile_image|string||
|tel|reference|null: false, foreign_key: true|
|address|reference|null: false, foreign_key: true|
|comment|reference|foreign_key: true|
|sns_credential|reference|foreign_key: true|
### Association
- has_many: comments
- has_many: items
- has_one: address
- has_many: credits
- has_one: tel
- has_one: authrization
- has_many: likes
- has_many: sns_credentials

## SnsCredentialテーブル
|Colimn|Type|Options|
|------|----|-------|
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

## Telsテーブル
|Colimn|Type|Options|
|------|----|-------|
|user|reference|null: false, foreign_key: true|
|tel_number|integer|null: false|
### Association
- belongs_to: user
- has_one: authorization

## Authrizationsテーブル
|Colimn|Type|Options|
|------|----|-------|
|tel_id|reference|null: false, foreign_key: true|
|authrization_num|integer|null: false|
### Association
- belongs_to: tel

## Itemsテーブル
|Colimn|Type|Options|
|------|----|-------|
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
|status|string|null: false|
|daliverys|reference|null: false, foreugn_key: true|
|picture|string|null: false|
|saler_id|reference|null: false, foreign_key: true, class:User|
|buyer_id|reference|foreign_key: true, class: User|
|like|reference|foreign_key: true|
|user_rating|
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
### Association
- belongs_to: user
- belongs_to: items






