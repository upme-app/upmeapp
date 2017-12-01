class CreateProjectUploads < ActiveRecord::Migration[5.0]
  def change
    create_table :project_uploads do |t|
      t.references :project, foreign_key: true
      t.string :file
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
