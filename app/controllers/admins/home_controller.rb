class Admins::HomeController < Admins::ApplicationController
  before_action :authenticate_admin!, only: %i[index]
  
  def index; end
end
