class AddStartedToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :started, :boolean
  end
end
