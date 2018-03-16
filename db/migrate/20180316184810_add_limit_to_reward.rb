class AddLimitToReward < ActiveRecord::Migration[5.1]
  def change
    add_column :rewards, :claim_limit, :integer
  end
end
