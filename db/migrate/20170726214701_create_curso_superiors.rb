class CreateCursoSuperiors < ActiveRecord::Migration[5.0]
  def change
    create_table :curso_superiors do |t|
      t.string :nome

      t.timestamps
    end
  end
end
