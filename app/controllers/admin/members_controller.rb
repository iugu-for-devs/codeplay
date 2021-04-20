class Admin::MembersController < Admin::ApplicationController
  def index
    @members = Admin.all
  end

  def new
    @member = Admin.new
  end

  def create
    @member = Admin.new(**admin_params, password: Devise.friendly_token.first(8))

    if @member.save
      flash[:notice] = t('.success')
      redirect_to admin_members_path
    else
      render :new
    end
  end

  private

  def admin_params
    @member = params.require(:member).permit(:email, :name)
  end
end
