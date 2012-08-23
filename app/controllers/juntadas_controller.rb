class JuntadasController < InheritedResources::Base
  load_and_authorize_resource
  actions :new, :create, :show

  def create
    create!(:notice => "Juntada realizada com sucesso!")
  end

  def buscar
    @processo = Processo.find_by_numero_protocolo(params[:numero_protocolo])
    @juntada = Juntada.new
    respond_to :js
  end

  def desanexar
    @juntadas = Juntada.find_all_by_tipo("Anexar")
  end

  def desapensar
    @juntadas = Juntada.find_all_by_tipo("Apensar")
  end

  def desanexar_processo
    @juntada = Juntada.find(params[:id])
    @juntada.update_attribute(:processo_ids, params[:juntada][:processo_ids])
    if @juntada.anexado?
      redirect_to juntada_path(@juntada), notice: "Processos desanexado com sucesso"
    else
      redirect_to juntada_path(@juntada), notice: "Processos desapensado com sucesso"
    end
  end

  def atualizar_processos
    @juntada = Juntada.find_by_processo_principal_id(params[:processo_id])
    @processos = @juntada.processos
    respond_to :js
  end
end

