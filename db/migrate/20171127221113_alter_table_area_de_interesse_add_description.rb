class AlterTableAreaDeInteresseAddDescription < ActiveRecord::Migration[5.0]
  def change
    add_column :area_de_interesses, :description, :text
  end
end
