module LoginAdmin
  def login_admin(admin = Admin.create!(email: 'jane.doe@iugu.com.br', password: '123456'))
    login_as admin, scope: :admin
    admin
  end
end
