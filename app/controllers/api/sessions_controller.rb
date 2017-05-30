class API::SessionsController < API::ApiController
  skip_before_action :require_login!, only: [:create]

  def create
    resource = User.find_for_database_authentication(email: params[:email])
    return invalid_login_attempt unless resource

    if resource.valid_password?(params[:password])
      auth_token = resource.generate_auth_token
      render json: { auth_token: auth_token }
    else
      invalid_login_attempt
    end
  end

  def destroy
    resource = current_person
    resource.invalidate_auth_token
    head :ok
  end

  private

    def invalid_login_attempt
      render json: { error: "Wrong login or password." }, status: 401
    end
end
