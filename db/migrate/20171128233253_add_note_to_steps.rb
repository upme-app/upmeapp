class AddNoteToSteps < ActiveRecord::Migration[5.0]
  def change
    add_column :timeline_steps, :note, :integer
  end
end
