class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :password_confirmation])
  end

  # redirect to this page after login
  def after_sign_in_path_for(resource)
    "/users/#{current_user.id}"
  end

  rescue_from Pundit::NotAuthorizedError do
    redirect_to root_url, alert: 'You do not have access to this page'
  end

end
