class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound do
    render_error(message: "Não encontrado", status: :not_found)
  end

  rescue_from ActionController::RoutingError do
    render_error(message: "URL inválida", status: :not_found)
  end
end
