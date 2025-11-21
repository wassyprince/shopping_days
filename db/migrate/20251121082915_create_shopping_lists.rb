class CreateShoppingLists < ActiveRecord::Migration[7.1]
  def change
    create_table :shopping_lists do |t|
      t.date       :date, null: false
      t.references :user, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
