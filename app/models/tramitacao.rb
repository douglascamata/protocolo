class Tramitacao < ActiveRecord::Base
  attr_accessible :setor_destino_id, :setor_origem_id, :requerimento_id, :setor_origem, :setor_destino
  
  belongs_to :setor_origem, class_name: 'Setor'
  belongs_to :setor_destino, class_name: 'Setor'
  belongs_to :requerimento

  validates_presence_of :setor_destino, :setor_origem, :requerimento
end
