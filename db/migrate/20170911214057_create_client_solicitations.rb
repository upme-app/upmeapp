class CreateClientSolicitations < ActiveRecord::Migration[5.0]
  def change
    create_table :client_solicitations do |t|
      t.references :project, foreign_key: true
      t.references :user, foreign_key: true
      t.text :message

      t.timestamps
    end
  end
end
