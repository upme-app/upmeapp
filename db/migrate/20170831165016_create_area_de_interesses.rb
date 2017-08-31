class CreateAreaDeInteresses < ActiveRecord::Migration[5.0]
  def change
    create_table :area_de_interesses do |t|
      t.string :name

      t.timestamps
    end
  end
end
