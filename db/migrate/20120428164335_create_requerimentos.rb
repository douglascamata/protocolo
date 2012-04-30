class CreateRequerimentos < ActiveRecord::Migration
  def change
    create_table :requerimentos do |t|
      t.string :numero_protocolo
      t.string :requerente
      t.string :interessado
      t.string :setor
      t.string :destino_inicial
      t.string :tipo_solicitacao
      t.text :conteudo

      t.timestamps
    end
  end
end

