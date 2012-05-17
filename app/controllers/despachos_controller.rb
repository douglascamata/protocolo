class DespachosController < InheritedResources::Base
  actions :new, :create, :show

  def create
    create!(:notice => "Despacho adicionado.")
  end
end
