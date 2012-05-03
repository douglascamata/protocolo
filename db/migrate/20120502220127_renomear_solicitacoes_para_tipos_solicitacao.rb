class RenomearSolicitacoesParaTiposSolicitacao < ActiveRecord::Migration
  def up
    rename_table :solicitacoes, :tipos_solicitacao
    rename_column :tipos_solicitacao, :tipo, :descricao
  end

  def down
    rename_column :tipos_solicitacao, :descricao, :tipo
    rename_table :tipos_solicitacao, :solicitacoes
  end
end
