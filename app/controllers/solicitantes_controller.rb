class SolicitantesController < InheritedResources::Base
  actions :new, :create, :show

  def create
    create!(:notice => "Solicitante criado com sucesso!")
  end

end

