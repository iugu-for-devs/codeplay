require 'rails_helper'

describe 'Admin auth' do
  it 'Admin can logn in' do
    admin = Fabricate(:admin)

    visit new_admin_session_path

    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_on 'Log in'

    expect(current_path).to eq(admins_root_path)
    expect(page).to have_text('Login efetuado com sucesso!')
  end
end
