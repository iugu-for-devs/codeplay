class Admins::DashboardController < Admins::ApplicationController
  before_action :authenticate_admin!, only: %i[index]

  def index
    render layout: 'admin'
  end
end
