require 'rails_helper'

describe 'Token company management' do
  it 'set company token' do
    admin = Fabricate(:admin)
    login_as(admin, scope: :admin)

    visit admin_root_path
    click_on 'Token'
    click_on 'Cadastrar'
    fill_in 'Token', with: 'token123456'
    click_on 'Salvar'

    expect(page).to have_text('Token cadastrado com sucesso')
    expect(page).to have_text('token123456')
    expect(page).to_not have_link('Cadastrar')
  end

  it 'edit company token' do
    admin = Fabricate(:admin)
    login_as(admin, scope: :admin)
    Fabricate(:company_token)

    visit admin_company_tokens_path
    click_on 'Editar'
    fill_in 'Token', with: '123456token'
    click_on 'Salvar'

    expect(page).to have_text('123456token')
    expect(page).to have_text('Token atualizado com sucesso')
  end

  it 'create and token cannot be blank' do
    admin = Fabricate(:admin)
    login_as(admin, scope: :admin)

    visit new_admin_company_token_path
    click_on 'Salvar'

    expect(current_path).to eq(admin_company_tokens_path)
    expect(page).to have_text('Token não pode ficar em branco')
  end
end
