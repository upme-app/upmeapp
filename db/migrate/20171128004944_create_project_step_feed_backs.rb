class CreateProjectStepFeedBacks < ActiveRecord::Migration[5.0]
  def change
    create_table :project_step_feedbacks do |t|
      t.integer :note
      t.text :description
      t.references :user, foreign_key: true
      t.references :project, foreign_key: true
      t.references :timeline_step, foreign_key: true

      t.timestamps
    end
  end
end
