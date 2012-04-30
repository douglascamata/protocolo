class CreateSolicitacoes < ActiveRecord::Migration
  def change
    create_table :solicitacoes do |t|
      t.string :tipo

      t.timestamps
    end
  end
end

