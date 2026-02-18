class AddOwnerIdToPlans < ActiveRecord::Migration[7.1]
  def change
    add_column :plans, :owner_id, :integer
  end
end
