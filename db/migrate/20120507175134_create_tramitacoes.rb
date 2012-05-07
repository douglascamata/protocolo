class CreateTramitacoes < ActiveRecord::Migration
  def change
    create_table :tramitacoes do |t|
      t.integer :setor_origem_id
      t.integer :setor_destino_id

      t.timestamps
    end
  end
end
