class SetoresController < InheritedResources::Base
  load_and_authorize_resource
  actions :new, :create, :show

  def create
    create!(:notice => "Setor criado com sucesso!")
  end

end

