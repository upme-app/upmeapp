class AddCheckdateToStep < ActiveRecord::Migration[5.0]
  def change
    add_column :timeline_steps, :check_date, :datetime
  end
end
