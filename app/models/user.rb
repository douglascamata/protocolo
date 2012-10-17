class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :role
  # attr_accessible :title, :body

  has_one :solicitante
  has_many :setores, :through => :solicitante

  def admin?
    role == 'admin'
  end

  def solicitante?
    !self.solicitante.nil?
  end

  def no_meu_setor?(processo)
    self.setores.include? processo.setor_atual
  end

  def papel
    if self.admin?
      :administrador
    elsif self.solicitante?
      :solicitante
    end
  end
end
