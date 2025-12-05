## Users

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| name               | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |

### Association
has_many :shopping_lists, dependent: :destroy
has_many :plan_users
has_many :plans, through: :plan_users
has_many :edit_histories, dependent: :nullify
has_one :notification, dependent: :destroy


## ShoppingLists

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| date   | date       | null: false                    |
| user   | references | null: false, foreign_key: true |
| title  | string     | null: false                    | 

### Association
belongs_to :user
has many   :items, dependent: :destroy
has many   :edit_histories, dependent: :destroy


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
has many   :edit_histories, , dependent: :nullify


## EditHistory

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| action          | integer    | null: false                    |
| item            | references | null: true, foreign_key: true  |
| user            | references | null: false, foreign_key: true |
| shopping_list   | references | null: false, foreign_key: true |
| list_title      | string     | ------------------------------ |
| before_name     | string     | ------------------------------ |
| after_name      | string     | ------------------------------ |
| before_quantity | integer    | ------------------------------ |
| after_quantity  | integer    | ------------------------------ |
| before_category | string     | ------------------------------ |
| after_category  | string     | ------------------------------ |

### Association
belongs_to :user
belongs_to :shopping_list
belongs_to :item, optional: true


## Notifications

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
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
has_many :plan_users, dependent: :destroy
has_many :users, through: :plan_users


## Plan_User
| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| plan	      | references | null: false, foreign_key: true |
| user        | references | null: false, foreign_key: true |

### Association
belongs_to :plan
belongs_to :user