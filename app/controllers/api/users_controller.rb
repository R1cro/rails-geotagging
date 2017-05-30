class API::UsersController < API::ApiController
  before_action :require_authentication!
  def index
    render json: { users: User.all }
  end

  def show
    render json: { user: User.find(params[:id]) }
  end

  # TODO
  # Add more actions for users.
end
