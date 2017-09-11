class CreateProjectInvitations < ActiveRecord::Migration[5.0]
  def change
    create_table :project_invitations do |t|
      t.references :user_from
      t.references :user_to
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
