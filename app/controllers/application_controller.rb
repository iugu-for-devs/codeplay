class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:full_name, :email, :password, :birthdate, :cpf, :password_confirmation,
               :zipcode, :number, :street, :complement, :state, :city)
    end

    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:full_name, :email, :password, :current_password, :birthdate, :password_confirmation,
               :cpf, :zipcode, :number, :street, :complement, :state, :city)
    end
  end
end
