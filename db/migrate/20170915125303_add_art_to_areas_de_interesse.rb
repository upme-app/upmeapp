class AddArtToAreasDeInteresse < ActiveRecord::Migration[5.0]
  def change
    AreaDeInteresse.create({name: 'Arte'})
  end
end
