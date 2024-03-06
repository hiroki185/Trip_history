class AddCategoryToTravels < ActiveRecord::Migration[6.1]
  def change
    add_column :travels, :category, :string
  end
end
