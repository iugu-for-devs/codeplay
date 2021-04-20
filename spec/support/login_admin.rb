module LoginAdmin
  def login_admin(admin = Admin.create!(name: 'Admin 1', email: 'admin1@codeplay.com.br', password: '123456'))
    login_as admin, scope: :admin
    admin
  end
end
