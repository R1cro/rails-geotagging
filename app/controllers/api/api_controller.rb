class API::ApiController < ApplicationController
  before_action :require_authentication!

  def require_authentication!
    return true if authenticate_token
    render json: { error: "Access denied. Your token is totally bullshit. Check it, please." }, status: 401
  end

  protected

    def authenticate_token
      authenticate_with_http_token do |token, options|
        User.find_by(auth_token: token)
      end
    end
end
