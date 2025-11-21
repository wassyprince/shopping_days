class ShoppingList < ApplicationRecord
  belongs_to :user
  
  def start_time
    date
  end

  validates :date, presence: true
end
