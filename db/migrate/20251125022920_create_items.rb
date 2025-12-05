class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.integer :quantity, null: false
      t.string :category, null: false
      t.text :memo, null: true
      t.boolean :purchased, null: false, default: false
      t.references :shopping_list, null: false, foreign_key: true

      t.timestamps
    end
  end
end
