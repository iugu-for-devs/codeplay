module LoginUser
  def login_user(user = Fabricate(:user))
    login_as user, scope: :user
    user
  end
end
