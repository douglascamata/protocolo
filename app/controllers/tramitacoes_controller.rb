class TramitacoesController < InheritedResources::Base
  actions :new, :create, :show

  def new
    @tramitacao = Tramitacao.new
  end

  def create
    create!(:notice => "Processos enviados.")
  end

  def atualizar_processos
    @processos_filtrados = Processo.filtrados_por_setor
    respond_to :js
  end
end
