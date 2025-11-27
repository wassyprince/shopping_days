class RemoveUserIdFromPlans < ActiveRecord::Migration[7.1]
  def change
    remove_column :plans, :user_id, :integer
  end
end
