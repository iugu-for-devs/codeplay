require 'rails_helper'

RSpec.describe Admin, type: :model do
  it 'admin can log with valid email and password' do
    admin = Fabricate(:admin)

    login_admin(admin)

    expect(admin.valid_password?(admin.password)).to be_truthy
    expect(admin.email).to eq('jane.doe@codeplay.com.br')
  end

  it 'admin can not log with valid email but unvalid password' do
    admin = Fabricate(:admin)

    login_admin(admin)

    expect(admin.valid_password?('1234567')).to be_falsey
  end

  it 'admin can not log with invalid email and unvalid password' do
    admin = Fabricate(:admin, email: 'teste@codeplay.com.br')

    login_admin(admin)

    expect(admin.valid_password?('1234567')).to be_falsey
    expect(admin.email).not_to eq('jane.doe@codeplay.com.br')
  end
end
