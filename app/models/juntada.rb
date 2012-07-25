class Juntada < ActiveRecord::Base
  attr_accessible :tipo, :processo_ids, :processo_principal_id
  has_many :processos
  belongs_to :processo_principal, class_name: 'Processo'

  validates_presence_of :tipo, :processos, :processo_principal

  def anexado?
    tipo == 'Anexar'
  end

end

