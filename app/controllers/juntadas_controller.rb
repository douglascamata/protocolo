class JuntadasController < InheritedResources::Base
  actions :new, :create, :show

  def new
    @juntada = Juntada.new
  end

  def create
    create!(:notice => "Juntada realizada com sucesso!")
  end

  def buscar
    @processo = Processo.find_by_numero_protocolo(params[:numero_protocolo])
    @juntada = Juntada.new
    respond_to :js
  end
end

