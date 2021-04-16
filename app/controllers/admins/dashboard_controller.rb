class Admins::DashboardController < Admins::ApplicationController
  def index
    render layout: 'admin'
  end
end
