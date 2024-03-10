class AddDefaultToNameInUsers < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :name, from: nil, to: "旅人"
  end
end
