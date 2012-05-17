class Despacho < ActiveRecord::Base
  attr_accessible :conteudo, :requerimento_id   

  belongs_to :requerimento

  validates_presence_of :conteudo, :requerimento
end
