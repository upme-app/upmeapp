class Areas < ActiveRecord::Migration[5.0]
  def change
    drop_table :area_not_found_notifications 
    AreaDeInteresse.where('name != ? and name != ?', "Marketing", "Administração").destroy_all
    AreaDeInteresse.create({name: 'Gestão'})
  end
end
