require 'rails_helper'

describe 'Admin authorization' do
  it 'Admin can log in' do
    admin = Fabricate(:admin)

    visit new_admin_session_path

    fill_in 'E-mail', with: admin.email
    fill_in 'Senha', with: admin.password
    click_on 'Login'

    expect(current_path).to eq(admin_root_path)
    expect(page).to have_text('Login efetuado com sucesso!')
  end

  it 'Admin logs out' do
    admin = Fabricate(:admin)

    visit new_admin_session_path

    fill_in 'E-mail', with: admin.email
    fill_in 'Senha', with: admin.password
    click_on 'Login'
    click_on 'Sair'
    page.driver.browser.switch_to.alert.accept

    expect(page).to have_text('Saiu com sucesso.')
    expect(page).not_to have_link('Sair')
    expect(current_path).to eq(root_path)
  end
end
