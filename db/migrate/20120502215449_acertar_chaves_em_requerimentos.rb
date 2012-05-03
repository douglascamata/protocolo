class AcertarChavesEmRequerimentos < ActiveRecord::Migration
  def up
    change_table :requerimentos do |t|
      t.remove :requerente
      t.remove :interessado
      t.remove :setor
      t.remove :destino_inicial
      t.remove :tipo_solicitacao

      t.references :requerente
      t.references :interessado
      t.references :setor_origem
      t.references :destino_inicial
      t.references :tipo_solicitacao
    end

    %w(requerente_id interessado_id setor_origem_id destino_inicial_id
       tipo_solicitacao_id).each {|index| add_index :requerimentos, index }

    execute <<-SQL
      ALTER TABLE requerimentos
        ADD CONSTRAINT fk_requerimentos_requerente
        FOREIGN KEY (requerente_id)
        REFERENCES solicitantes(id);

      ALTER TABLE requerimentos
        ADD CONSTRAINT fk_requerimentos_interessado
        FOREIGN KEY (interessado_id)
        REFERENCES solicitantes(id);

      ALTER TABLE requerimentos
        ADD CONSTRAINT fk_requerimentos_setor_origem
        FOREIGN KEY (setor_origem_id)
        REFERENCES setores(id);

      ALTER TABLE requerimentos
        ADD CONSTRAINT fk_requerimentos_destino_inicial
        FOREIGN KEY (destino_inicial_id)
        REFERENCES setores(id);

      ALTER TABLE requerimentos
        ADD CONSTRAINT fk_requerimentos_tipo_solicitacao
        FOREIGN KEY (tipo_solicitacao_id)
        REFERENCES solicitacoes(id);
    SQL
  end

  def down
   %w(fk_requerimentos_requerente fk_requerimentos_interessado
      fk_requerimentos_setor_origem fk_requerimentos_destino_inicial
      fk_requerimentos_tipo_solicitacao).
    each {|fk| execute "ALTER TABLE requerimentos DROP CONSTRAINT #{fk}" }

    %w(requerente_id interessado_id setor_origem_id destino_inicial_id
       tipo_solicitacao_id).each {|index| remove_index :requerimentos, index }

    change_table :requerimentos do |t|
      t.remove :requerente_id
      t.remove :interessado_id
      t.remove :setor_origem_id
      t.remove :destino_inicial_id
      t.remove :tipo_solicitacao_id

      t.string :requerente
      t.string :interessado
      t.string :setor
      t.string :destino_inicial
      t.string :tipo_solicitacao
    end
  end
end
