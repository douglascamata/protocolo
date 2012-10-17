# encoding: utf-8
class UsersController < InheritedResources::Base
  load_and_authorize_resource
  actions :new, :create, :show

  def create
    @user = User.new(params[:user])
    @user.role = 'admin'

    if @user.save
      redirect_to user_path(@user), notice: "Administrador criado com sucesso!"
    else
      render 'new'
    end
  end

end
