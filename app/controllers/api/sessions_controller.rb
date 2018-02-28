class API::SessionsController < API::BaseController
  before_action :require_authentication!, only: [:destroy]

  def create
    user = User.find_for_database_authentication(email: params[:user][:email])
    return invalid_login_attempt unless user

    if user.valid_password?(params[:user][:password])
      @current_user = user
      auth_token = @current_user.generate_auth_token
      render json: { user: @current_user.attributes.except("password", "password_confirmation"), status: 200, token: auth_token },
             status: 200
    else
      invalid_login_attempt
    end
  end

  def destroy
    @current_user = nil if @current_user.invalidate_auth_token
    render json: { status: 200, message: "User signed out." }, status: 200
  end

  private

    def invalid_login_attempt
      render json: { error: "Wrong login or password." }, status: 401
    end
end
