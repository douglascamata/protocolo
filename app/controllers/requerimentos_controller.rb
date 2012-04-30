class RequerimentosController < InheritedResources::Base

  def new
    @requerimento = Requerimento.new
    @requerimento.numero_protocolo = Requerimento.gerar_numero_protocolo
  end

end

