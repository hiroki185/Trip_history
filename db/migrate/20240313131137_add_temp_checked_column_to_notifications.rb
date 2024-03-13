class AddTempCheckedColumnToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :temp_checked, :boolean, default: false
    Notification.reset_column_information
    Notification.update_all(temp_checked: false)
    remove_column :notifications, :checked
    rename_column :notifications, :temp_checked, :checked
  end
end
