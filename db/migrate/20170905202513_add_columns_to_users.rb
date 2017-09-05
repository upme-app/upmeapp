class AddColumnsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :universidade, :string
    add_column :users, :semestre, :string
    add_column :users, :about, :text
    add_column :users, :linkedin, :string
    add_column :users, :phone, :string
    add_column :users, :city, :string
  end
end
