class CreateProjectEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :project_events do |t|
      t.references :project, foreign_key: true
      t.references :user, foreign_key: true
      t.string :title
      t.text :description
      t.datetime :start_date
      t.datetime :end_date
      t.timestamps
    end
  end
end
