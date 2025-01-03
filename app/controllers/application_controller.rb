class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # Configuração de paramentro para permitir login com account_num
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :email, :account_num, :password, :password_confirmation, :vip ])
    devise_parameter_sanitizer.permit(:sign_in, keys: [ :login, :password, :password_confirmation ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :email, :account_num, :current_password, :password_confirmation, :vip  ])
  end
end
