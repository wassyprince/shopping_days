class RenameMemoAndAddBeforeMemoToEditHistories < ActiveRecord::Migration[7.1]
  def change
    rename_column :edit_histories, :memo, :after_memo
    change_column :edit_histories, :after_memo, :text

    add_column :edit_histories, :before_memo, :text
  end
end
