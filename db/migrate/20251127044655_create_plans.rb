class CreatePlans < ActiveRecord::Migration[7.1]
  def change
    create_table :plans do |t|
      t.string :title
      t.datetime :start_time
      t.datetime :end_time
      t.text :note
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
