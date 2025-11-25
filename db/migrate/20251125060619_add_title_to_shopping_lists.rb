class AddTitleToShoppingLists < ActiveRecord::Migration[7.1]
  def change
    add_column :shopping_lists, :title, :string
  end
end
