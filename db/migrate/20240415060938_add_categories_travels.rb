class AddCategoriesTravels < ActiveRecord::Migration[6.1]

  def change
    create_table :categories do |t|
      t.string :name
      t.timestamps
    end
    create_table :categories_travels, id: false do |t|
      t.belongs_to :category
      t.belongs_to :travel
    end
  end
end
