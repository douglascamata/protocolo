class SetoresSolicitantes < ActiveRecord::Migration
  def change
    create_table :setores_solicitantes do |t|
      t.integer :solicitante_id
      t.integer :setor_id
    end
  end
end
