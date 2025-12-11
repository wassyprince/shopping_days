class AddMemoToEditHistories < ActiveRecord::Migration[7.1]
  def change
    add_column :edit_histories, :memo, :string
  end
end
