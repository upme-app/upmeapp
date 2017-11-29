class AddGeografyCityIdToProfile < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :geography_city_id, :integer
  end
end
