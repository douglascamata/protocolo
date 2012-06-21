class AddJuntadaToProcesso < ActiveRecord::Migration
  def change
    add_column :processos, :juntada_id, :integer
  end
end

