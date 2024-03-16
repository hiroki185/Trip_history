class AddGeocodingColumnToTravel < ActiveRecord::Migration[6.1]
  def change
    add_column :travels, :latitude, :float, null: false, default: 0
    add_column :travels, :longitude, :float, null: false, default: 0
  end
end
