class CreateAreaNotFoundNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :area_not_found_notifications do |t|
      t.references :area_de_interesse, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
