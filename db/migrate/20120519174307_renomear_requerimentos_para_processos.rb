class RenomearRequerimentosParaProcessos < ActiveRecord::Migration
  def up
    rename_table :requerimentos, :processos
    rename_column :despachos, :requerimento_id, :processo_id
    rename_column :tramitacoes, :requerimento_id, :processo_id
  end

  def down
    rename_column :despachos, :processo_id, :requerimento_id
    rename_column :tramitacoes, :processo_id, :requerimento_id
    rename_table :processos, :requerimentos
  end
end
