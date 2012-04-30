class Requerimento < ActiveRecord::Base
  attr_accessible :conteudo, :numero_protocolo, :setor, :requerente, :interessado, :destino_inicial, :tipo_solicitacao
  validates_presence_of :conteudo, :setor, :requerente, :numero_protocolo, :destino_inicial, :tipo_solicitacao
  validates_uniqueness_of :numero_protocolo


  def self.gerar_numero_protocolo
    if Requerimento.all.empty?
      @@numero = "1"
      (5 - @@numero.length).times{@@numero.insert 0, "0"}
    else
      @@numero = (Requerimento.last.id + 1).to_s
      (5 - @@numero.length).times{@@numero.insert 0, "0"}
    end
    @@numero + "/" + Date.today.year.to_s[-2..-1]
  end

end

