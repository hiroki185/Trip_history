class AddBodyToUsers < ActiveRecord::Migration[6.1]
  def up
    change_column :users, :body, :text
  end

  def down
    change_column :users, :body, :string
  end
end