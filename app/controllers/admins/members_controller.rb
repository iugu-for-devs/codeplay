class Admins::MembersController < Admins::ApplicationController
  # TODO: verificar se é super admin

  def index
    @members = Admin.all
  end

  def new
    @member = Admin.new
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

  private

  def admin_params
    params.require(:member).permit(:email, :password)
  end
end
