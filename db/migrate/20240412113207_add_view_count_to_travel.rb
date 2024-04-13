class AddViewCountToTravel < ActiveRecord::Migration[6.1]
  def change
    add_column :travels, :view_count, :integer
  end
end
