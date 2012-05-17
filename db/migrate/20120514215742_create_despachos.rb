class CreateDespachos < ActiveRecord::Migration
  def change
    create_table :despachos do |t|
      t.text :conteudo

      t.timestamps
    end
  end
end
