## Users

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| name               | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |

### Association
has many :shopping_lists
has many :edit_histories
has many :notifications


## ShoppingLists

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| date   | date       | null: false                   |
| user   | references | null: false, foreign_key: true |

### Association
belongs_to :user
has many   :items
has many   :edit_histories


## Items

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| name          | string     | null: false                    |
| quantity      | integer    | null: false                    |
| category      | string     | null: false                    |
| memo          | string     | null: true                     |
| purchased     | boolean    | null: false, default: false    |
| shopping_list | references | null: false, foreign_key: true |

### Association
belongs_to :shopping_list
has many   :edit_histories


## EditHistory

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| action        | string     | null: false                    |
| timestamp     | datetime   | null: false                    |
| item          | references | null: false, foreign_key: true |
| user          | references | null: false, foreign_key: true |
| shopping_list | references | null: false, foreign_key: true |

### Association
belongs_to :user
belongs_to :shopping_list
belongs_to :item


## Notifications

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| message     | text       | null: false                    |
| notify_time | datetime   | null: false                    |
| enabled     | boolean    | null: false, default: true     |
| user        | references | null: false, foreign_key: true |

### Association
belongs_to :user