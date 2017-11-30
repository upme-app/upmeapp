class AlterTableTimelineStepAddOrder < ActiveRecord::Migration[5.0]
  def change
   add_column :timeline_steps, :position, :integer
  end
  
end
