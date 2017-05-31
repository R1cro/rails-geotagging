class API::BaseController < ApplicationController
  before_action :require_authentication!

  def require_authentication!
    return true if authenticate_token
    render json: { error: "Access denied." }, status: 401
  end

  protected

    def authenticate_token
      authenticate_with_http_token do |token, options|
        User.find_by(auth_token: token)
      end
    end
end
