# encoding: utf-8
class TramitacoesController < InheritedResources::Base
  load_and_authorize_resource
  actions :new, :create, :show

  def create
    @tramitacao = Tramitacao.new(params[:tramitacao])
    @processo = @tramitacao.processo

    if @tramitacao.save
      @tramitacao.destroy
      if @processo.enviar_para(@tramitacao.setor_destino) 
        redirect_to processo_path(@tramitacao.processo), :notice => "Processos enviados."
      else
        redirect_to new_tramitacao_path, :alert => 'Processo não pode ser enviado.'
      end
    else 
      render 'new'
    end
  end

  def atualizar_processos
    @processos = Processo.filtrados_por_setor[Setor.find(params[:setor_id])].select { |processo| processo.criado? or processo.recebido? }
    respond_to :js
  end
end
