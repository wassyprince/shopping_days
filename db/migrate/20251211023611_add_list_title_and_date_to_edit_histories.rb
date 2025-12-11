class AddListTitleAndDateToEditHistories < ActiveRecord::Migration[7.1]
  def change
    add_column :edit_histories, :before_list_title, :string
    add_column :edit_histories, :after_list_title, :string
    add_column :edit_histories, :before_date, :date
    add_column :edit_histories, :after_date, :date
  end
end
