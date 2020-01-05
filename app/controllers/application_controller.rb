class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  add_flash_types :danger, :info, :warning, :success

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :username, :password_confirmation)}

    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password, :username, :password_confirmation)}
  end

end
