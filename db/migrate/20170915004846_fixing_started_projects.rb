class FixingStartedProjects < ActiveRecord::Migration[5.0]

  def up
    Project.all.update_all({ started: false })
    Project.where('client_id IS NOT null').update_all({ started: true })
  end

end
