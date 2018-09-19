class ApplicationController < ActionController::API
  include Error::ErrorHandler
  include DeviseTokenAuth::Concerns::SetUserByToken

  before_action :configure_permitted_parameters, if: :devise_controller?

  alias_method :current_user, :current_api_v1_user

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def not_found
    raise ActiveRecord::RecordNotFound
  end

end
