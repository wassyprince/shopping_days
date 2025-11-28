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
has_many :plan_users
has_many :plans, through: :plan_users


## ShoppingLists

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| date   | date       | null: false                    |
| user   | references | null: false, foreign_key: true |
| title  | string     | null: false                    | 

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
| memo          | text       | null: true                     |
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


## Plans

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| title	      | string	   | null: false                    |
| note        |	text	     | null: true                     |
| start_time	| datetime	 | null: false                    |
| end_time    |	datetime	 | null: false                    |

### Association
has_many :plan_users
has_many :users, through: :plan_users


## Plan_User
| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| plan	      | bigint	   | null: false, foreign_key: true |
| user        | bigint     | null: false, foreign_key: true |

### Association
belongs_to :plan
belongs_to :user