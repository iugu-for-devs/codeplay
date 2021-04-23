require 'rails_helper'

describe 'user registration' do
  it 'visit register page' do
    visit root_path
    assert_text 'Code Play'
    assert_text 'Entrar'
    assert_text 'Cadastrar'

    click_on 'Cadastrar'
    assert_current_path new_user_registration_path

    assert_no_text 'Cadastrar'
    assert_text 'Nome completo'
    assert_text 'Email'
    assert_text 'Senha'
    assert_text 'Confirmar senha'
    assert_text 'Data de nascimento'
    assert_text 'CPF'
    assert_text 'Endereço'
    assert_text 'Rua'
    assert_text 'Número'
    assert_text 'Complemento'
    assert_text 'CEP'
    assert_text 'Cidade'
    assert_text 'Estado'
    expect(page).to have_selector(:button, 'Cadastrar')
  end

  it 'register a new user' do
    visit root_path
    assert_text 'Code Play'
    click_on 'Cadastrar'

    assert_current_path new_user_registration_path
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
    assert_current_path root_path
    assert_text 'Uma mensagem com um link de confirmação foi enviada para o seu endereço de e-mail.'
  end

  it 'user cannot register with empty email' do
    visit root_path
    assert_text 'Code Play'
    click_on 'Cadastrar'

    assert_current_path new_user_registration_path
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

    assert_current_path user_registration_path
    assert_text 'Não foi possível salvar usuário'
  end

  it 'user cannot register with empty password' do
    visit root_path
    assert_text 'Code Play'
    click_on 'Cadastrar'

    assert_current_path new_user_registration_path
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
    assert_current_path user_registration_path
    assert_text 'Não foi possível salvar usuário'
  end

  it 'user cannot register with gmail domain' do
    visit root_path
    assert_text 'Code Play'
    click_on 'Cadastrar'

    assert_current_path new_user_registration_path

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
    assert_current_path user_registration_path
    assert_text 'Email não é válido'
  end

  it 'user email must be unique to register' do
    user = Fabricate(:user)
    visit root_path
    assert_text 'Code Play'

    click_on 'Cadastrar'

    assert_current_path new_user_registration_path

    fill_in 'Email', with: user.email
    fill_in 'Senha', with: '12345678'
    fill_in 'Confirmar senha', with: '12345678'
    within 'form' do
      click_on 'Cadastrar'
    end
    assert_current_path user_registration_path
    assert_text 'Não foi possível salvar usuário'
  end

  it 'user password cant be less than eight characters long to register' do
    visit root_path
    assert_text 'Code Play'

    click_on 'Cadastrar'

    assert_current_path new_user_registration_path

    fill_in 'Email', with: 'jhon.doe@codesaga.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirmar senha', with: '123456'
    within 'form' do
      click_on 'Cadastrar'
    end
    assert_current_path user_registration_path
    assert_text 'Não foi possível salvar usuário'
  end

  it 'user login' do
    user = Fabricate(:user)
    user.confirm
    visit root_path
    click_on 'Entrar'

    assert_current_path new_user_session_path
    expect(page).to have_no_link('Entrar')

    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password

    click_on 'Login'

    assert_current_path root_path

    assert_text 'Login efetuado com sucesso!'
  end

  it 'user cannot login with empty email' do
    user = Fabricate(:user)
    visit root_path
    click_on 'Entrar'

    assert_current_path new_user_session_path

    fill_in 'Senha', with: user.password

    click_on 'Login'

    assert_current_path user_session_path
    assert_text 'Email ou senha inválida'
  end

  it 'user cannot login with empty password' do
    user = Fabricate(:user)
    visit root_path
    click_on 'Entrar'

    assert_current_path new_user_session_path

    fill_in 'Email', with: user.email

    click_on 'Login'

    assert_current_path user_session_path
    assert_text 'Email ou senha inválida'
  end

  it 'user cannot login with unregistered email' do
    visit root_path
    click_on 'Entrar'
    assert_current_path new_user_session_path

    fill_in 'Email', with: 'jhon.due@codesaga.com'
    fill_in 'Senha', with: '12345678'

    click_on 'Login'

    assert_current_path user_session_path
    assert_text 'Email ou senha inválida'
  end

  it 'user logout' do
    user = Fabricate(:user)
    user.confirm
    login_as user, scope: :user
    visit user_session_path

    assert_current_path root_path

    assert_no_text 'Entrar'
    assert_no_text 'Cadastrar'
    assert_text user.email

    click_on 'Sair'

    assert_current_path root_path
    assert_text 'Entrar'
    assert_text 'Cadastrar'
    assert_text 'Saiu com sucesso.'
  end

  it 'user cannot login without email confirmation' do
    user = Fabricate(:user)
    visit root_path
    click_on 'Entrar'

    assert_current_path new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password

    click_on 'Login'

    assert_current_path user_session_path

    assert_text 'Antes de continuar, confirme a sua conta'
  end

  it 'user can request reset password' do
    user = Fabricate(:user)
    user.confirm

    visit user_session_path
    click_on 'Esqueceu sua senha?'
    assert_current_path new_user_password_path
    assert_text 'Esqueceu sua senha?'
    fill_in 'Email', with: user.email
    click_on 'Enviar instruções de recuperação de senha'

    assert_current_path user_session_path
    assert_text 'Dentro de minutos, você receberá um e-mail com instruções para a troca da sua senha.'
  end

  it 'user can create a new password' do
    user = Fabricate(:user)
    user.confirm
    token = user.send_reset_password_instructions
    visit edit_user_password_path(reset_password_token: token)

    fill_in 'Nova senha', with: '1234567890'
    fill_in 'Confirmar nova senha', with: '1234567890'
    click_on 'Mudar minha senha'

    assert_text 'Sua senha foi alterada com sucesso. Você está logado.'
    assert_current_path root_path
  end

  xit 'user cannot login without recaptcha' do
    # TODO
  end

  # TODO: Definir para qual path o usuário será direcionado após o login
  # TODO: Add 'home' link to all pages except root_path
  # TODO: Refatorar logon com login as (definir método e chamar)
end
