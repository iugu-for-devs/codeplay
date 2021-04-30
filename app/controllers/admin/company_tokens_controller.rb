class Admin::CompanyTokensController < Admin::ApplicationController
  before_action :set_company_token, only: %i[edit update]

  def index
    @company_token = CompanyToken.current_token
  end

  def new
    @company_token = CompanyToken.new
  end

  def create
    @company_token = CompanyToken.new params_token
    if @company_token.save
      redirect_to admin_company_tokens_path, notice: t('.success')
    else
      render :new
    end
  end

  def edit; end

  def update
    @company_token.update params_token
    redirect_to admin_company_tokens_path, notice: t('.success')
  end

  private

  def set_company_token
    @company_token = CompanyToken.first
  end

  def params_token
    params.require(:company_token).permit(:token)
  end
end
