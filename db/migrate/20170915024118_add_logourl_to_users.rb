class AddLogourlToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :logourl, :string
  end
end
