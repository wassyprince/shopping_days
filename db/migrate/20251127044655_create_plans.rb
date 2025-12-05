class CreatePlans < ActiveRecord::Migration[7.1]
  def change
    create_table :plans do |t|
      t.string :title, null: false
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.text :note, null: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
