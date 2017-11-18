class AlterTablePaymentAddStatus < ActiveRecord::Migration[5.0]
  def change
    remove_column :payments, :paid
    add_column :payments, :status, :integer
  end
end
