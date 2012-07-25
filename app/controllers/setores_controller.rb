class SetoresController < InheritedResources::Base
  actions :new, :create, :show

  def create
    create!(:notice => "Setor criado com sucesso!")
  end

end

