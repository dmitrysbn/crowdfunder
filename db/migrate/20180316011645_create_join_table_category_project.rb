class CreateJoinTableCategoryProject < ActiveRecord::Migration[5.1]
  def change
    create_join_table :categories, :projects, table_name: :categorizations do |t|
      # t.index [:category_id, :project_id]
      # t.index [:project_id, :category_id]
    end
  end
end
