class Item < ApplicationRecord
  belongs_to :shopping_list
  has_many   :edit_histories, dependent: :nullify

  validates :name, presence: true  # アイテム名が必須
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 1 }  # 数量が1以上
  validates :category, presence: true  # カテゴリが必須
end
