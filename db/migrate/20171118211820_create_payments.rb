class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.references :user, foreign_key: true
      t.references :project, foreign_key: true
      t.boolean :paid, default: :false
      t.numeric :order_amount
      t.string :currency
      t.text :description

      t.timestamps
    end
  end
end
