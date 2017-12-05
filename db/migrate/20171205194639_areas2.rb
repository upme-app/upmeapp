class Areas2 < ActiveRecord::Migration[5.0]
  def change
    ProjectAreaDeInteresse.where(area_de_interesse_id: nil).destroy_all
    drop_table :user_area_de_interesses
  end
end
