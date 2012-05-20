class ProcessosController < InheritedResources::Base
  actions :new, :create, :show

  def receber
    if params[:id] # PUT receber_processo_path(:id)
      processo = Processo.find(params[:id])
      processo.receber!
      flash[:notice] = "Processo #{processo.numero_protocolo} recebido com sucesso"
      redirect_to receber_processos_path
    else # GET receber_processos_path
      @setores = Setor.all
    end
  end

  def aguardando_recebimento
    @processos = Processo.aguardando_recebimento_em(Setor.find(params[:setor_id]))
    respond_to :js
  end
end
