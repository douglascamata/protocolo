class AddEncerramentoToProcessos < ActiveRecord::Migration
  def change
    add_column :processos, :observacoes, :text
    add_column :processos, :motivo_id, :integer
    add_column :processos, :data_hr_encerramento, :string
  end
end
