class Admins::MembersController < Admins::ApplicationController
  before_action :authenticate_admin!, only: %i[index new]
  #TODO: verificar se é super admin
  def index
    @members = Admin.all
    render layout: 'admin'
  end

  def new
    @member = Admin.new
    render layout: 'admin'
  end

  def create
    @member = Admin.new(admin_params)
    if @member.save
      redirect_to admins_members_path
    else
      flash.now[:alert] = 'Nāo foi cadastrar'
      render :new
    end
  end

  def show
    @member = Admin.find(params[:id])
  end

  private

  def admin_params
    params.require(:member).permit(:email, :password)
  end
end
