class TramitacoesController < InheritedResources::Base
  actions :new, :create, :show

  def new
    @tramitacao = Tramitacao.new
  end

  def create
    create!(:notice => "Processos enviados.")
  end

  def atualizar_requerimentos
    @requerimentos_filtrados = Requerimento.filtrados_por_setor
    respond_to :js
  end
end
