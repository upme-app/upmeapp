class AddFeedbackToSteps < ActiveRecord::Migration[5.0]

  def change
    add_column :timeline_steps, :feedback, :text
  end

end
