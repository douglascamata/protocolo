class Tramitacao < ActiveRecord::Base
  attr_accessible :setor_destino_id, :setor_origem_id, :requerimento_ids
  
  belongs_to :setor_origem, class_name: 'Setor'
  belongs_to :setor_destino, class_name: 'Setor'

  has_and_belongs_to_many :requerimentos

  validates_presence_of :setor_destino, :setor_origem, :requerimentos
end
