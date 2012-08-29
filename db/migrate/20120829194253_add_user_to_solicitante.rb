class AddUserToSolicitante < ActiveRecord::Migration
  def change
    add_column :solicitantes, :user_id, :integer
  end
end
