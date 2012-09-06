class ProcessosController < InheritedResources::Base
  actions :new, :create, :show
  load_and_authorize_resource except: [:aguardando_recebimento, :aguardando_reabrimento, :buscar]

  def receber
    if params[:id] # PUT receber_processo_path(:id)
      processo = Processo.find(params[:id])
      processo.receber!
      redirect_to receber_processos_path, notice: "Processo #{processo.numero_protocolo} recebido com sucesso"
    else # GET receber_processos_path
      @setores = Setor.all
    end
  end

  def aguardando_recebimento
    @processos = Processo.aguardando_recebimento_em(Setor.find(params[:setor_id]))
    respond_to :js
  end

  def encerrar
    if params[:id]
      processo = Processo.find(params[:id])
      processo.update_attributes(params[:processo])
      processo.encerrar!
      redirect_to processo_path(processo), notice: "Processo encerrado."
    end
  end

  def buscar
    @processo = Processo.find_by_numero_protocolo(params[:numero_protocolo])
    respond_to :js
  end

  def reabrir
    if params[:id] # PUT receber_processo_path(:id)
      processo = Processo.find(params[:id])
      processo.reabrir!
      redirect_to reabrir_processos_path, notice: "Processo #{processo.numero_protocolo} foi reaberto"
    else # GET receber_processos_path
      @setores = Setor.all
    end
  end

  def aguardando_reabrimento
    @processos = Processo.aguardando_reabrimento_em(Setor.find(params[:setor_id]))
    respond_to :js
  end

  def consultar
    if params[:q]
      params[:q].delete_if{|key, value| value == "-1" || value == ""}
    end
    @q = Processo.search(params[:q])
    @processo = @q.result(:distinct => true)
  end
end

