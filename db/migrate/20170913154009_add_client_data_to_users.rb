class AddClientDataToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :nome_empresa, :string
  end
end
