class AddRequerimentoToDespachos < ActiveRecord::Migration
  def change
    add_column :despachos, :requerimento_id, :integer
  end
end
