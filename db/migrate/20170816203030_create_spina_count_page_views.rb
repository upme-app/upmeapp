class CreateSpinaCountPageViews < ActiveRecord::Migration[5.0]
  def change
    create_table :spina_count_page_views do |t|
      t.integer :page_id
      t.string :ip

      t.timestamps
    end
  end
end
