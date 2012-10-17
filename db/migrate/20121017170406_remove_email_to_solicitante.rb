class RemoveEmailToSolicitante < ActiveRecord::Migration
  def up
    remove_column :solicitantes, :email
      end

  def down
    add_column :solicitantes, :email, :string
  end
end
