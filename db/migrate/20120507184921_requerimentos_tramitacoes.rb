class RequerimentosTramitacoes < ActiveRecord::Migration
  def change
    create_table :requerimentos_tramitacoes do |t|
      t.integer :requerimento_id
      t.integer :tramitacao_id
    end
  end
end
