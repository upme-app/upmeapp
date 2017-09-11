class CreateProjectUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :project_users do |t|
      t.references :project, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
