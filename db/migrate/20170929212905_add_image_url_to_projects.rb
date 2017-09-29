class AddImageUrlToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :imgurl, :string, default: nil
  end
end
