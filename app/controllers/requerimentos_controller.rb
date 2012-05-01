class RequerimentosController < InheritedResources::Base
  def create
    @requerimento = Requerimento.new(params[:requerimento])
    if @requerimento.save
      redirect_to @requerimento
    else
      render action: 'new'
    end
  end
end
