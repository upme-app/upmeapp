class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :title
      t.text :objective
      t.text :description
      t.boolean :nat_privada
      t.boolean :nat_publica
      t.boolean :nat_ong
      t.string :target_audience
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
