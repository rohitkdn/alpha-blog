class AddAdminToUsers < ActiveRecord::Migration[5.1]
  def change
    add column :users, :admin, :boolean, default: false
  end
end
