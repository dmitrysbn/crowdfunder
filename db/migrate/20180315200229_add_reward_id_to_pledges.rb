class AddRewardIdToPledges < ActiveRecord::Migration[5.1]
  def change
    add_column :pledges, :reward_id, :integer
  end
end
