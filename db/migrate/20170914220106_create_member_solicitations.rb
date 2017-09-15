class CreateMemberSolicitations < ActiveRecord::Migration[5.0]
  def change
    create_table :member_solicitations do |t|
      t.references :project, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
