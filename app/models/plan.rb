class Plan < ApplicationRecord
  has_many :plan_users
  has_many :users, through: :plan_users

  validates :title, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
end
