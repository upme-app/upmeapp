class AddAreasDeInteresse < ActiveRecord::Migration[5.0]
  def change
    AreaDeInteresse.create({name: 'Design'})
    AreaDeInteresse.create({name: 'Marketing'})
    AreaDeInteresse.create({name: 'Engenharias'})
    AreaDeInteresse.create({name: 'Tecnologia'})
    AreaDeInteresse.create({name: 'Comunicação'})
    AreaDeInteresse.create({name: 'Arquitetura'})
    AreaDeInteresse.create({name: 'Administração'})
    AreaDeInteresse.create({name: 'Outros'})
  end
end
