class DeletarRequerimentosTramitacoes < ActiveRecord::Migration
  def up
    drop_table :requerimentos_tramitacoes
  end

  def down
    create_table :requerimentos_tramitacoes do |t|
      t.integer :requerimento_id
      t.integer :tramitacao_id
    end
  end
end
