class AddAddressToTravels < ActiveRecord::Migration[6.1]
  def change
    add_column :travels, :address, :string
  end
end
