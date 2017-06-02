class API::BaseController < ApplicationController
  before_action :require_authentication!

  respond_to :json

  protect_from_forgery with: :null_session

  def require_authentication!
    return true if authenticate_token
    render json: { error: "Access denied. Your token is invalidated or expired." }, status: 401
  end

  protected

    def authenticate_token
      authenticate_with_http_token do |token, options|
        User.where(auth_token: token).where("token_created_at >= ?", 1.day.ago).first
      end
    end
end
