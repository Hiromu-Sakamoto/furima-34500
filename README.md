# furimaのER図

## users テーブル

| Column           | Type   | Options     |
| ---------------- | ------ | ----------- |
| email            | string | null: false |
| password         | string | null: false |
| nickname         | string | null: false |
| family_name      | string | null: false |
| first_name       | string | null: false |
| family_name_kana | string | null: false |
| first_name_kana  | string | null: false |
| birth_day        |  date  | null: false |

### Association

- has_many :items dependent: :destroy
- has_many :orders
- has_one :card

## cards テーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| card_number     | integer    | null: false                    |
| expiration_date | date       | null: false                    |
| security_code   | integer    | null: false                    |
| user_id         | references | null: false, foreign_key: true |

### Association

- belongs_to :user

## orders テーブル

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| items_id       | integer    | null: false, foreign_key: true |
| user_id        | references | null: false, foreign_key: true |
| destination_id | integer    | null: false, foreign_key: true |
| card_id        | integer    | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- belongs_to :destination
- belongs_to :card

## destinations テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| postal_code   | integer    | null: false                    |
| prefecture    | date       | null: false                    |
| city          | string     | null: false                    |
| address       | string     | null: false                    |
| building_name | string     | null: false                    |
| user_id       | references | null: false, foreign_key: true |

## items テーブル

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| item_name      | string     | null: false                    |
| price          | integer    | null: false                    |
| fee            | integer    | null: false                    |
| profit         | integer    | null: false                    |
| category       | string     | null: false                    |
| condition      | string     | null: false                    |
| charges        | integer    | null: false                    |
| delivery_area  | string     | null: false                    |
| Estimated_date | date       | null: false                    |
| user_id        | references | null: false, foreign_key: true |
### Association

- belongs_to :user
- has_one :order

## items テーブル
| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| image          |            | ActiveStorageで管理             |
