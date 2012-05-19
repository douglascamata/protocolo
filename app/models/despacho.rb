class Despacho < ActiveRecord::Base
  attr_accessible :conteudo, :processo_id

  belongs_to :processo

  validates_presence_of :conteudo, :processo
end
