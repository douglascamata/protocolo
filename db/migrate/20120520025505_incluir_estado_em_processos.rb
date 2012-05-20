class IncluirEstadoEmProcessos < ActiveRecord::Migration
  def up
    add_column :processos, :estado, :string
  end

  def down
    remove_column :processos, :estados
  end
end
