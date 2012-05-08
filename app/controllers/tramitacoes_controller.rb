class TramitacoesController < InheritedResources::Base
  actions :new, :create, :show

  def new
    @tramitacao = Tramitacao.new
    @requerimentos = Requerimento.filtrados
  end

  def create
    create!(:notice => "Processos enviados.")
  end
end
