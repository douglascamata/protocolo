class Setor < ActiveRecord::Base
  attr_accessible :nome
  validates_presence_of :nome
end

