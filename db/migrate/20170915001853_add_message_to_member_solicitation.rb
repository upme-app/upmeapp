class AddMessageToMemberSolicitation < ActiveRecord::Migration[5.0]
  def change
    add_column :member_solicitations, :message, :text
  end
end
