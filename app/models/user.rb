class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true

  has_many :shopping_lists, dependent: :destroy
  has_many :plan_users
  has_many :plans, through: :plan_users
  has_many :edit_histories
end
