class AddFieldToComment < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :posted_update, :boolean, default: false
  end
end
