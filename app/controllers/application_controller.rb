class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: "You dont have the permits to do this"
  end
  protected
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
  def configure_permitted_parameters
    keys = [:first_name, :last_name, :username, :admin]
    devise_parameter_sanitizer.permit(:sign_up, keys: keys)
    devise_parameter_sanitizer.permit(:account_update, keys: keys)
  end

end