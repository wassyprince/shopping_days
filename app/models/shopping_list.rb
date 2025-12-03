class ShoppingList < ApplicationRecord
  belongs_to :user
  has_many :items, dependent: :destroy  # dependent: :destroy は、ショッピングリスト削除時にアイテムも削除するオプション
  has_many :edit_histories, dependent: :destroy
  
  def start_time
    date
  end

  validates :date, presence: true
  validates :title, presence: true
end
