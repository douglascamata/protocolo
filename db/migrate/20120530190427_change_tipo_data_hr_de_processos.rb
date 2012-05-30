class ChangeTipoDataHrDeProcessos < ActiveRecord::Migration
  def up
    remove_column :processos, :data_hr_encerramento
    add_column :processos, :data_hr_encerramento, :datetime
  end

  def down
    remove_column :processos, :data_hr_encerramento
    add_column :processos, :data_hr_encerramento, :string
  end
end
