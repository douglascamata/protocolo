class Usuario < ActiveRecord::Base
  attr_accessible :papel
  validates_presence_of :papel
end
