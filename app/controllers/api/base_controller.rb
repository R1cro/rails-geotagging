class API::BaseController < ApplicationController
  before_action :require_authentication!

  respond_to :json

  protect_from_forgery with: :null_session

  before_action :destroy_session

  def require_authentication!
    return true if authenticate_token
    render json: { error: "Access denied. Your token is invalidated or expired." }, status: 401
  end

  protected

    def authenticate_token
      token, options = ActionController::HttpAuthentication::Token.token_and_options(request)
      email = options.blank? ? nil : options[:email]
      user = email && User.find_by(email: email) || User.find_by(auth_token: token)

      if user && ActiveSupport::SecurityUtils.secure_compare(user.auth_token, token)
        @current_user = user
      else
        false
      end
    end

  private

    def destroy_session
      request.session_options[:skip] = true
    end
end
