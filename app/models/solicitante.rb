class Solicitante < ActiveRecord::Base
  has_and_belongs_to_many :setores
  attr_accessible :nome, :endereco, :telefone, :email, :matricula, :setor_ids, :user_attributes
  validates_presence_of :nome, :matricula

  belongs_to :user

  accepts_nested_attributes_for :user
end
