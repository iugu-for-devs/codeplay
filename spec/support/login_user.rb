module LoginUser
  def login_user(user = User.create!(email: 'admin1@gmail.com.br', password: '12345678'))
    login_as user, scope: :user
    user
  end
end
