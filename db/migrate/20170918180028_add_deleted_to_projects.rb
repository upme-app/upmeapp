class AddDeletedToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :deleted, :boolean, default: false
  end
end
