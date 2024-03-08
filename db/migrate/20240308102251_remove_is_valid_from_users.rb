class RemoveIsValidFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :is_valid, :boolean
  end
end
