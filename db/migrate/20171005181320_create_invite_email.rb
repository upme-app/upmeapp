class CreateInviteEmail < ActiveRecord::Migration[5.0]
  def change
    create_table :invite_emails do |t|
      t.references :user, foreign_key: true
      t.string :to_email
      t.string :token
      t.references :project, foreign_key: true
      t.boolean :completed

      t.timestamps
    end
  end
end
