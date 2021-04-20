require 'rails_helper'

describe 'Admin creates' do
  it 'a valid new admin' do
    admin = Fabricate(:admin)

    login_admin(admin)

    visit admin_root_path
    click_on 'Membros'
    click_on 'Novo Membro'

    fill_in 'E-mail', with: 'gabriel@codeplay.com.br'
    fill_in 'Nome', with: 'Gabriel Silva'
    click_on 'Cadastrar Membro'

    expect(current_path).to eq(admin_members_path)
    expect(page).to have_text('Membro cadastrado com sucesso!')
    expect(page).to have_text('gabriel@codeplay.com.br')
    expect(page).to have_text('Gabriel Silva')
  end

  it "and can't create with inavlid email" do
    admin = Fabricate(:admin)

    login_admin(admin)

    visit admin_root_path
    click_on 'Membros'
    click_on 'Novo Membro'

    fill_in 'E-mail', with: 'gabriel@bol.com.br'
    fill_in 'Nome', with: 'Gabriel Silva'
    click_on 'Cadastrar Membro'

    expect(current_path).to eq(admin_members_path)
    expect(page).to have_text('Domínio não válido')
  end

  it 'and the email must be unique' do
    admin = Fabricate(:admin)

    login_admin(admin)

    visit admin_root_path
    click_on 'Membros'
    click_on 'Novo Membro'

    fill_in 'E-mail', with: 'jane.doe@codeplay.com.br'
    fill_in 'Nome', with: 'Jane Doe'
    click_on 'Cadastrar Membro'

    expect(current_path).to eq(admin_members_path)
    expect(page).to have_text('já está em uso')
  end
end
