class AddValueToUsers < ActiveRecord::Migration
  def change
    add_column :users, :following, :text
  end
end
