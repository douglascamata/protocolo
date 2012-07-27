class Solicitante < ActiveRecord::Base
  has_and_belongs_to_many :setores
  attr_accessible :nome, :endereco, :telefone, :email, :matricula, :setor_ids
  validates_presence_of :nome, :matricula
end
