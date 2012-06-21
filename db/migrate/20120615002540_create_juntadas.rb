class CreateJuntadas < ActiveRecord::Migration
  def change
    create_table :juntadas do |t|
      t.string :tipo
      t.integer :processo_principal_id

      t.timestamps
    end
  end
end

