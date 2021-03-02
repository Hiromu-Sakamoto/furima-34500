# furimaのER図

## users テーブル

| Column           | Type   | Options     |
| ---------------- | ------ | ----------- |
| email            | string | null: false |
| password         | string | null: false |
| nickname         |  text  | null: false |
| family_name      |  text  | null: false |
| first_name       |  text  | null: false |
| family_name_kana |  text  | null: false |
| first_name_kana  |  text  | null: false |
| birth_day        |  text  | null: false |

### Association

- has_many :items dependent: :destroy

## sipping_infomation テーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| user_id         | integer    | null: false, foreign_key: true |
| card number     | text       | null: false                    |
| expiration_date | text       | null: false                    |
| security code   | text       | null: false                    |
| postal code     | text       | null: false                    |
| prefecture      | text       | null: false                    |
| municipalitie   | text       | null: false                    |
| address         | text       | null: false                    |
| Building name   | text       | null: true                     |
| phone number    | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item

## items テーブル

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| name           | string     | null: false                    |
| price          | text       | null: false                    |
| fee            | text       | null: false                    |
| profit         |            | ActiveStorageで実施             |
| seller         | references | null: false, foreign_key: true |
| category       | text       | null: false                    |
| condition      | text       | null: false                    |
| charges        | text       | null: false                    |
| delivery area  | text       | null: false                    |
| Estimated date | text       | null: false                    |
| image          |            | ActiveStorageで実施             |
| user           | references | null: false, foreign_key: true |
### Association

- belongs_to :user
- has_one :account

