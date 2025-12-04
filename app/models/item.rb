class Item < ApplicationRecord
  belongs_to :shopping_list
  has_many   :edit_histories, dependent: :nullify

  validates :name, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :category, presence: true
end
