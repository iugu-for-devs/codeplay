require 'rails_helper'

describe 'Admin creates' do
  it 'a valid new admin' do
    admin = Fabricate(:admin)

    login_admin(admin)

    visit admins_root_path
    click_on 'Membros'
    click_on 'Novo Membro'

    fill_in 'Email', with: 'new_admin@codeplay.com.br'
    fill_in 'Password', with: rand(1..999_999)
    click_on 'Salvar'

    expect(current_path).to eq(admins_members_path)
    expect(page).to have_text('new_admin@codeplay.com.br')
  end
end
