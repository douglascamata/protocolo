class DespachosController < InheritedResources::Base
  load_and_authorize_resource
  actions :new, :create, :show

  def create
    create!(:notice => "Despacho adicionado.")
  end
end
