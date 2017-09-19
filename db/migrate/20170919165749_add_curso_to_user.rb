class AddCursoToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :curso, :string
  end
end
