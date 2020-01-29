## README
This README would normally document whatever steps are necessary to get the application up and running.

Things you may want to cover:

Ruby version

System dependencies

Configuration

Database creation

Database initialization

How to run the test suite

Services (job queues, cache servers, search engines, etc.)

Deployment instructions

...

## usersテーブル
|Column|Type|Option|
|------|----|------|
|nickname|string|null: false|
|email|string|null: false|
|password|string|null: false|
|password_confirmation|string|null: false|
|last_name|string|null: false|
|first_name|string|null: false|
|last_name_kana|string|null: false|
|first_name_kana|string|null: false|
|phone_number|integer|null: false|
|year_birth_at|integer|null: false|
|month_birth_at|integer|null: false|
|day_birth_at|integer|null: false|
### Association
- has_many :buyed_items, foreign_key: "buyer_id", class_name: "items"
- has_many :seller_items, -> {where("buywer_id is NULL")},
foreign_key: "seller_id", class_name: "items"
- has_many :addlesses
- has_one :profile

## addlessesテーブル
|Column|Type|Option|
|------|----|------|
|zipcode|string|null: false|
|city|string|null: false|
|town|string|null: false|
|house_number|string|null: false|
|building|string||
|phone_number|string||
|user_id|references|null: false|
### Association
- belongs_to :user

## profilesテーブル
|Column|Type|Option|
|------|----|------|
|body|text||
|image|string||
|user_id|references|null: false|
### Association
- belongs_to :user

## itemsテーブル
|Column|Type|Option|
|------|----|------|
|image|string|null: false|
|name|string|null: false|
|status|string|null: false|
|text|string|null: false|
|price|integer|null: false|
|fee|integer|null: false|
|region|string|null: false|
|delivery_day|integer|null: false|
|seller_id|references|null: false, foreign_key: true|
|buyer_id|references|foreign_key: true|
### Association
- belongs_to :seller, class_name: "User"
- belongs_to :buyer, class_name: "User"
- has_many :categories, through :items_categories

## items_categoriesテーブル 
|Column|Type|Option|
|------|----|------|
|items_id|references|null: false, foreign_key: true|
|category_id|references|null: false, foreign_key: true|
### Association
- belongs_to : items
- belongs_to : category

## categoriesテーブル 
|Column|Type|Option|
|------|----|------|
|name|string|null: false|
|path|string||
### Association
- has_many :items, through :items_categories