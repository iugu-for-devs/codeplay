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
      flash[:notice] = 'Membro cadastrado com sucesso!'
      # TODO: mandar email com dados de login
      redirect_to admins_members_path
    else
      flash[:alert] = @member.errors.full_messages
      render :new
    end
  end


  private

  def create_password
    Devise.friendly_token.first(8)
  end

  def admin_params
    with_password = params.require(:member).permit(:email, :name)
    with_password[:password] = create_password
    with_password
  end
end
