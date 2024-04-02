class AddBodyToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :body, :text
  end
end
