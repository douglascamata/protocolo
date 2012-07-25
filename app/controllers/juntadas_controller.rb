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

  def desapensar
    @juntadas = Juntada.find_all_by_tipo("Apensar")
  end

  def desanexar_processo
    @juntada = Juntada.find(params[:id])
    @juntada.update_attribute(:processo_ids, params[:juntada][:processo_ids])
    redirect_to juntada_path(@juntada), notice: "Processos desapensado com sucesso"
  end
end

