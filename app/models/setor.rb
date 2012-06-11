class Setor < ActiveRecord::Base
  attr_accessible :nome

  has_many :tramitacoes, :foreign_key => :setor_destino_id
  has_many :processos, :through => :tramitacoes
end

