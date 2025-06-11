class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :authorize_admin!
  def index
    if current_user.admin?
      @users = User.all
    else
      redirect_to chats_path, alert: "No tienes acceso a esta página."
    end
  end

  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
  @user = User.new(user_params)
  if @user.save
    redirect_to @user, notice: 'User was successfully created.'
  else
    render :new, status: :unprocessable_entity
  end
  end


  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end
 def authorize_admin!
    unless current_user.admin?
      redirect_to chats_path, alert: "No tienes permiso para acceder a esta página."
    end
  end


  
  private
  
  def user_params
    if current_user&.admin?
      params.require(:user).permit(:email, :password, :password_confirmation, :admin, :first_name, :last_name)
    else
      params.require(:user).permit(:email, :password, :password_confirmation, :admin, :first_name, :last_name)
    end
  end
  
end
