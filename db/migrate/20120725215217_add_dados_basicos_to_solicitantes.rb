class AddDadosBasicosToSolicitantes < ActiveRecord::Migration
  def change
    add_column :solicitantes, :endereco, :string
    add_column :solicitantes, :telefone, :string
    add_column :solicitantes, :email, :string
    add_column :solicitantes, :matricula, :string
  end
end

