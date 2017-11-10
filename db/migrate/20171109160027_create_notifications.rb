class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.references :user, foreign_key: true
      t.boolean :read, default: :false
      t.string :description
      t.string :url

      t.timestamps
    end
  end
end
