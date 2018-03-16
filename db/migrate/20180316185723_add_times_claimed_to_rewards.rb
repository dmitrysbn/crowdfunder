class AddTimesClaimedToRewards < ActiveRecord::Migration[5.1]
  def change
    add_column :rewards, :times_claimed, :integer, :default => 0
  end
end
