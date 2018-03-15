class CreateProjectcategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories_projects do |t|
      t.belongs_to :project
      t.belongs_to :category
      t.timestamps
    end
  end
end
