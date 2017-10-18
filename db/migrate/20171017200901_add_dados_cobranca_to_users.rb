class AddDadosCobrancaToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :cpf, :string
    add_column :users, :telefone, :string
    add_column :users, :endereco, :string
    add_column :users, :numero, :string
    add_column :users, :bairro, :string
    add_column :users, :cidade, :string
    add_column :users, :uf, :string
    add_column :users, :cep, :string
  end
end
