class API::SessionsController < API::BaseController
  skip_before_action :require_authentication!, only: [:create]

  def create
    resource = User.find_for_database_authentication(email: params[:user][:email])
    return invalid_login_attempt unless resource

    if resource.valid_password?(params[:user][:password])
      auth_token = resource.generate_auth_token
      render json: { user: resource.attributes.except("password", "password_confirmation"), status: 200, token: auth_token },
             status: 200
    else
      invalid_login_attempt
    end
  end

  def destroy
    auth_header = request.headers["Authorization"]
    auth_token = token_and_options(auth_header)
    user = User.find_by(auth_token: auth_token)
    user.invalidate_auth_token
    render json: { status: 200, message: "User signed out." }, status: 200
  end

  private

    def invalid_login_attempt
      render json: { error: "Wrong login or password." }, status: 401
    end

    def token_and_options(auth_string)
      if header = auth_string.to_s[/^Token (.*)/]
        values = $1.split(",").
          inject({}) do |memo, value|
          value.strip!
          key, value = value.split(/\=\"?/)
          value.chomp!('"')
          value.gsub!(/\\\"/, '"')
          memo.update(key => value)
        end
        values.delete("token")
      end
    end
end
