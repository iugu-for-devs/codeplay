require 'rails_helper'

describe 'Admin authorization' do
  it 'Admin can log in' do
    admin = Fabricate(:admin)

    visit new_admin_session_path

    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_on 'Log in'

    expect(current_path).to eq(admins_root_path)
    expect(page).to have_text('Login efetuado com sucesso!')
  end

  it 'Admin logs out' do
    admin = Fabricate(:admin)

    visit new_admin_session_path

    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_on 'Log in'
    click_on 'Sair'
    page.driver.browser.switch_to.alert.accept

    expect(page).to have_text('Saiu com sucesso.')
    expect(page).not_to have_link('Sair')
    expect(current_path).to eq(root_path)
  end
  #TODO: quando deslogar, redirecionar para admins_root_path, não o root normal (que vai acabar caindo na tela de log_in)
end
