class IncluirRecebidaEmEmTramitacoes < ActiveRecord::Migration
  def up
    add_column :tramitacoes, :recebida_em, :datetime
  end

  def down
    remove_column :tramitacoes, :recebida_em
  end
end
