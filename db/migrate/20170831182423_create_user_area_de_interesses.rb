class CreateUserAreaDeInteresses < ActiveRecord::Migration[5.0]
  def change
    create_table :user_area_de_interesses do |t|
      t.references :user, foreign_key: true
      t.references :area_de_interesse, foreign_key: true

      t.timestamps
    end
  end
end
