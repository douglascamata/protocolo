class SolicitantesController < InheritedResources::Base
  load_and_authorize_resource
  actions :new, :create, :show

  def new
    @solicitante = Solicitante.new
    @solicitante.user = User.new
  end

  def create
    create!(:notice => "Solicitante criado com sucesso!")
  end

end

