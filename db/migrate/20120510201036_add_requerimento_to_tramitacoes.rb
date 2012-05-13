class AddRequerimentoToTramitacoes < ActiveRecord::Migration
  def change
    add_column :tramitacoes, :requerimento_id, :integer
  end
end
