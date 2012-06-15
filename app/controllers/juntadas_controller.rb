class JuntadasController < InheritedResources::Base
  actions :new, :create, :show

  def new
    @juntada = Juntada.new
  end

  def create
    create!(:notice => "Juntada realizada com sucesso!")
  end
end

