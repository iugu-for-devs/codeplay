require 'rails_helper'

describe 'user registration' do
  it 'visit register page' do
    visit root_path
    expect(page).to have_text('Code Play')
    expect(page).to have_text('Entrar')
    expect(page).to have_text('Cadastrar')

    click_on 'Cadastrar'
    expect(current_path).to eq(new_user_registration_path)

    expect(page).not_to have_text('Cadastrar')
    expect(page).to have_text('Nome completo')
    expect(page).to have_text('Email')
    expect(page).to have_text('Senha')
    expect(page).to have_text('Confirmar senha')
    expect(page).to have_text('Data de nascimento')
    expect(page).to have_text('CPF')
    expect(page).to have_text('Endereço')
    expect(page).to have_text('Rua')
    expect(page).to have_text('Número')
    expect(page).to have_text('Complemento')
    expect(page).to have_text('CEP')
    expect(page).to have_text('Cidade')
    expect(page).to have_text('Estado')
    expect(page).to have_button('Cadastrar')
  end

  it 'register a new user' do
    visit root_path
    expect(page).to have_text('Code Play')
    click_on 'Cadastrar'

    expect(current_path).to eq(new_user_registration_path)
    fill_in 'Nome completo', with: 'John Doe'
    fill_in 'Email', with: 'john.doe@codesaga.com.br'
    fill_in 'Senha', with: '12345678'
    fill_in 'Confirmar senha', with: '12345678'
    fill_in 'Data de nascimento', with: '08/08/1990'
    fill_in 'CPF', with: '000.000.003-53'
    fill_in 'Rua', with: 'Av. Marechal Tito'
    fill_in 'Número', with: '36'
    fill_in 'Complemento', with: 'Apto 48'
    fill_in 'CEP', with: '08040-150'
    fill_in 'Cidade', with: 'São Paulo'
    fill_in 'Estado', with: 'SP'
    within 'form' do
      click_on 'Cadastrar'
    end
    expect(current_path).to eq(root_path)
    expect(page).to have_text('Uma mensagem com um link de confirmação foi enviada para o seu endereço de e-mail.')
  end

  it 'user cannot register with empty email' do
    visit root_path
    expect(page).to have_text('Code Play')
    click_on 'Cadastrar'

    expect(current_path).to eq(new_user_registration_path)
    fill_in 'Nome completo', with: 'John Doe'
    fill_in 'Senha', with: '12345678'
    fill_in 'Confirmar senha', with: '12345678'
    fill_in 'Data de nascimento', with: '08/08/1990'
    fill_in 'CPF', with: '000.000.003-53'
    fill_in 'Rua', with: 'Av. Marechal Tito'
    fill_in 'Número', with: '36'
    fill_in 'Complemento', with: 'Apto 48'
    fill_in 'CEP', with: '08040-150'
    fill_in 'Cidade', with: 'São Paulo'
    fill_in 'Estado', with: 'SP'
    fill_in 'Senha', with: '12345678'
    fill_in 'Confirmar senha', with: '12345678'
    within 'form' do
      click_on 'Cadastrar'
    end

    expect(current_path).to eq(user_registration_path)
    expect(page).to have_text('Não foi possível salvar usuário')
  end

  it 'user cannot register with empty password' do
    visit root_path
    expect(page).to have_text('Code Play')
    click_on 'Cadastrar'

    expect(current_path).to eq(new_user_registration_path)
    fill_in 'Nome completo', with: 'John Doe'
    fill_in 'Email', with: 'john.doe@codesaga.com.br'
    fill_in 'Data de nascimento', with: '08/08/1990'
    fill_in 'CPF', with: '000.000.003-53'
    fill_in 'Rua', with: 'Av. Marechal Tito'
    fill_in 'Número', with: '36'
    fill_in 'Complemento', with: 'Apto 48'
    fill_in 'CEP', with: '08040-150'
    fill_in 'Cidade', with: 'São Paulo'
    fill_in 'Estado', with: 'SP'
    within 'form' do
      click_on 'Cadastrar'
    end
    expect(current_path).to eq(user_registration_path)
    expect(page).to have_text('Não foi possível salvar usuário')
  end

  it 'user cannot register with gmail domain' do
    visit root_path
    expect(page).to have_text('Code Play')
    click_on 'Cadastrar'

    expect(current_path).to eq(new_user_registration_path)

    fill_in 'Nome completo', with: 'John Doe'
    fill_in 'Email', with: 'john.doe@gmail.com'
    fill_in 'Senha', with: '12345678'
    fill_in 'Confirmar senha', with: '12345678'
    fill_in 'Data de nascimento', with: '08/08/1990'
    fill_in 'CPF', with: '000.000.003-53'
    fill_in 'Rua', with: 'Av. Marechal Tito'
    fill_in 'Número', with: '36'
    fill_in 'Complemento', with: 'Apto 48'
    fill_in 'CEP', with: '08040-150'
    fill_in 'Cidade', with: 'São Paulo'
    fill_in 'Estado', with: 'SP'
    within 'form' do
      click_on 'Cadastrar'
    end
    expect(current_path).to eq(user_registration_path)
    expect(page).to have_text('Email não é válido')
  end

  it 'user email must be unique to register' do
    user = Fabricate(:user)
    visit root_path
    expect(page).to have_text('Code Play')

    click_on 'Cadastrar'

    expect(current_path).to eq(new_user_registration_path)

    fill_in 'Email', with: user.email
    fill_in 'Senha', with: '12345678'
    fill_in 'Confirmar senha', with: '12345678'
    within 'form' do
      click_on 'Cadastrar'
    end
    expect(current_path).to eq(user_registration_path)
    expect(page).to have_text('Não foi possível salvar usuário')
  end

  it 'user password cant be less than eight characters long to register' do
    visit root_path
    expect(page).to have_text('Code Play')

    click_on 'Cadastrar'

    expect(current_path).to eq(new_user_registration_path)

    fill_in 'Email', with: 'jhon.doe@codesaga.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirmar senha', with: '123456'
    within 'form' do
      click_on 'Cadastrar'
    end
    expect(current_path).to eq(user_registration_path)
    expect(page).to have_text('Não foi possível salvar usuário')
  end
end

describe 'user login' do
  it 'user can login' do
    user = Fabricate(:user)
    user.confirm
    visit root_path
    click_on 'Entrar'

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_no_link('Entrar')

    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password

    click_on 'Login'

    expect(current_path).to eq(root_path)

    expect(page).to have_text('Login efetuado com sucesso!')
  end

  it 'user cannot login with empty email' do
    user = Fabricate(:user)
    visit root_path
    click_on 'Entrar'

    expect(current_path).to eq(new_user_session_path)

    fill_in 'Senha', with: user.password

    click_on 'Login'

    expect(current_path).to eq(user_session_path)
    expect(page).to have_text('Email ou senha inválida')
  end

  it 'user cannot login with empty password' do
    user = Fabricate(:user)
    visit root_path
    click_on 'Entrar'

    expect(current_path).to eq(new_user_session_path)

    fill_in 'Email', with: user.email

    click_on 'Login'

    expect(current_path).to eq(user_session_path)
    expect(page).to have_text('Email ou senha inválida')
  end

  it 'user cannot login with unregistered email' do
    visit root_path
    click_on 'Entrar'
    expect(current_path).to eq(new_user_session_path)

    fill_in 'Email', with: 'jhon.due@codesaga.com'
    fill_in 'Senha', with: '12345678'

    click_on 'Login'

    expect(current_path).to eq(user_session_path)
    expect(page).to have_text('Email ou senha inválida')
  end

  it 'user logout' do
    user = Fabricate(:user)
    user.confirm
    login_as user, scope: :user
    visit user_session_path

    expect(current_path).to eq(root_path)

    expect(page).not_to have_text('Entrar')
    expect(page).not_to have_text('Cadastrar')
    expect(page).to have_text(user.email)

    click_on 'Sair'

    expect(current_path).to eq(root_path)
    expect(page).to have_text('Entrar')
    expect(page).to have_text('Cadastrar')
    expect(page).to have_text('Saiu com sucesso.')
  end

  it 'user cannot login without email confirmation' do
    user = Fabricate(:user)
    visit root_path
    click_on 'Entrar'

    expect(current_path).to eq(new_user_session_path)

    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password

    click_on 'Login'

    expect(current_path).to eq(user_session_path)

    expect(page).to have_text('Antes de continuar, confirme a sua conta')
  end
end

describe 'user can change password' do
  it 'user can request reset password' do
    user = Fabricate(:user)
    user.confirm

    visit user_session_path
    click_on 'Esqueceu sua senha?'
    expect(current_path).to eq(new_user_password_path)
    expect(page).to have_text('Esqueceu sua senha?')
    fill_in 'Email', with: user.email
    click_on 'Enviar instruções de recuperação de senha'

    expect(current_path).to eq(user_session_path)
    expect(page).to have_text('Dentro de minutos, você receberá um e-mail com instruções para a troca da sua senha.')
  end

  it 'user can create a new password' do
    user = Fabricate(:user)
    user.confirm
    token = user.send_reset_password_instructions
    visit edit_user_password_path(reset_password_token: token)

    fill_in 'Nova senha', with: '1234567890'
    fill_in 'Confirmar nova senha', with: '1234567890'
    click_on 'Mudar minha senha'

    expect(page).to have_text('Sua senha foi alterada com sucesso. Você está logado.')
    expect(current_path).to eq(root_path)
  end
end
