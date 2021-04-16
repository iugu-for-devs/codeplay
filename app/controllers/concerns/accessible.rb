module Accessible
  extend ActiveSupport::Concern
  included do
    before_action :check_user
  end
  

  protected

  def check_user
    # if you have rails_admin. You can redirect anywhere really
    redirect_to(admins_root_path, flash: { notice: 'Login efetuado com sucesso!' }) and return if current_admin

    # The authenticated root path can be defined in your routes.rb in: devise_scope :user do...
    redirect_to(authenticated_user_root_path) and return if current_user
  end
end
