require 'rails_helper'

describe 'Admin creates' do
  it 'a valid new admin' do
    admin = Fabricate(:admin)

    login_admin(admin)

    visit admins_root_path
    click_on 'Membros'
    click_on 'Novo Membro'

    fill_in 'Email', with: 'gabriel@codeplay.com.br'
    fill_in 'Nome', with: 'Gabriel Silva'
    click_on 'Salvar'

    expect(current_path).to eq(admins_members_path)
    expect(page).to have_text('Membro cadastrado com sucesso!')
    expect(page).to have_text('gabriel@codeplay.com.br')
  end

  it "and can't create with inavlid email" do
    admin = Fabricate(:admin)

    login_admin(admin)

    visit admins_root_path
    click_on 'Membros'
    click_on 'Novo Membro'

    fill_in 'Email', with: 'gabriel@bol.com.br'
    fill_in 'Nome', with: 'Gabriel Silva'
    click_on 'Salvar'

    expect(current_path).to eq(admins_members_path)
    expect(page).to have_text('Domínio não válido')
  end
end
