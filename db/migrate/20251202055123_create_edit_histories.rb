class CreateEditHistories < ActiveRecord::Migration[7.1]
  def change
    create_table :edit_histories do |t|
      t.integer :action, null: false
      t.references :user, null: false, foreign_key: true
      t.references :shopping_list, null: false, foreign_key: true
      t.references :item, null: true, foreign_key: true
      t.string :list_title

      t.timestamps
    end
  end
end
