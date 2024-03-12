class AddFavoritesCountToFavorites < ActiveRecord::Migration[6.1]
  def change
    add_column :favorites, :favorites_count, :integer, default: 0
  end
end
