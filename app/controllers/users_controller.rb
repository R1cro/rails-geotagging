class UsersController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized

  def index
    @users = User.all
    authorize User
   end

  #GET "/users/:id"
  def show
    @user = User.find(params[:id])
    authorize @user
    @dynamic_objects = @user.dynamic_objects
    @connections = @user.connections
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update_attributes(secure_params)
      redirect_to :back, notice: "User updated."
    else
      redirect_to :back, alert: "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    authorize user
    user.destroy
    redirect_to users_path, notice: "User deleted."
  end

  def location
    @users = User.all
    authorize User
  end

  private

    def secure_params
      params.require(:user).permit(:role)
    end
end
