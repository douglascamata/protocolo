class Setor < ActiveRecord::Base
  has_and_belongs_to_many :solicitantes
  attr_accessible :nome
  validates_presence_of :nome
  validates_uniqueness_of :nome
end
