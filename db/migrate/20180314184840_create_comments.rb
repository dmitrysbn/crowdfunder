class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.text :comment
      t.belongs_to :project
      t.belongs_to :user
      t.timestamps
    end
  end
end
