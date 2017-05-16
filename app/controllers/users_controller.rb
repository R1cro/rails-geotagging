class UsersController < ApplicationController
  before_action :authenticate_user!

  #GET "/users/:id"
  def show
    @user = User.find(params[:id])
    @dynamic_objects = @user.dynamic_objects
    @connections = @user.connections
  end
end
