class CreateTimelineSteps < ActiveRecord::Migration[5.0]
  def change
    create_table :timeline_steps do |t|
      t.references :project, foreign_key: true
      t.string :title
      t.text :description
      t.text :entregavel
      t.date :entrega

      t.timestamps
    end
  end
end
