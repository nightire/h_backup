class AddIndexToUsersUseremail < ActiveRecord::Migration
  def change
    add_index :users, :useremail, unique: true
  end
end
