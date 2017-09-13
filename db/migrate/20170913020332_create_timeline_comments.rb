class CreateTimelineComments < ActiveRecord::Migration[5.0]
  def change
    create_table :timeline_comments do |t|
      t.text :message
      t.references :user, foreign_key: true
      t.references :timeline_step, foreign_key: true

      t.timestamps
    end
  end
end
