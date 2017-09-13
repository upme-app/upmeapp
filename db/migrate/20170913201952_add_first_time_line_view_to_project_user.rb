class AddFirstTimeLineViewToProjectUser < ActiveRecord::Migration[5.0]
  def change
    add_column :project_users, :first_timeline_view, :boolean, default: false
  end
end
