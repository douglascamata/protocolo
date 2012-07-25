class Solicitante < ActiveRecord::Base
  attr_accessible :nome, :endereco, :telefone, :email, :matricula
end

