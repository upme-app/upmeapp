class AddGeografyStateIdToProfile < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :geography_state_id, :integer
  end
end
