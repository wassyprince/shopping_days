class AddBeforeAfterToEditHistories < ActiveRecord::Migration[7.1]
  def change
    add_column :edit_histories, :before_name, :string
    add_column :edit_histories, :after_name, :string
    add_column :edit_histories, :before_quantity, :integer
    add_column :edit_histories, :after_quantity, :integer
    add_column :edit_histories, :before_category, :string
    add_column :edit_histories, :after_category, :string
    add_column :edit_histories, :before_purchased, :boolean
    add_column :edit_histories, :after_purchased, :boolean
  end
end
