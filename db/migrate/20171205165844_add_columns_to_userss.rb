class AddColumnsToUserss < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :site, :string
    add_column :users, :natureza, :integer
  end
end
