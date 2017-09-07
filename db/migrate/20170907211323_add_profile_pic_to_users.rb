class AddProfilePicToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :profilepicurl, :string
  end
end
