class Solicitante < ActiveRecord::Base
  attr_accessible :nome, :endereco, :telefone, :email, :matricula
  validates_presence_of :nome, :matricula
end

