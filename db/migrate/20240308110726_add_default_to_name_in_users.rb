class AddDefaultToNameInUsers < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :name, :string, default: "旅人"
  end
end
