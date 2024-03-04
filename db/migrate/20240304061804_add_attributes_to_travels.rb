class AddAttributesToTravels < ActiveRecord::Migration[6.1]
  def change
    add_column :travels, :amount_range, :string
    add_column :travels, :transportation, :string
  end
end
