require 'rails_helper'

describe 'user registration' do
  context 'when user makes a new registration' do
    it 'show registrations fields ' do
      visit root_path
      expect(page).to have_button('Entrar')
      expect(page).to have_button('Nova Conta')

      first(:button, 'Nova Conta').click
      expect(current_path).to eq(new_user_registration_path)
      expect(page).to have_text('Nome completo')
      expect(page).to have_text('E-mail')
      expect(page).to have_text('Senha')
      expect(page).to have_text('Confirmar Senha')
      expect(page).to have_button('Cadastrar')
    end
  end

  it 'register a new user' do
    visit root_path
    first(:button, 'Nova Conta').click

    expect(current_path).to eq(new_user_registration_path)
    fill_in 'Nome completo', with: 'John Doe'
    fill_in 'E-mail', with: 'john.doe@codesaga.com.br'
    fill_in 'Senha', with: '12345678'
    fill_in 'Confirmar Senha', with: '12345678'
    click_on 'Cadastrar'

    expect(current_path).to eq(root_path)
  end

  context 'when register with blank mandatory fields' do
    it 'user cannot register with empty email' do
      visit root_path
      click_on 'Nova Conta'

      expect(current_path).to eq(new_user_registration_path)
      fill_in 'Nome completo', with: 'John Doe'
      fill_in 'Senha', with: '12345678'
      fill_in 'Confirmar Senha', with: '12345678'
      click_on 'Cadastrar'

      expect(current_path).to eq(user_registration_path)
      expect(page).to have_text('Não foi possível salvar aluno')
    end

    it 'user cannot register with empty password' do
      visit new_user_registration_path

      fill_in 'Nome completo', with: 'John Doe'
      fill_in 'E-mail', with: 'john.doe@codesaga.com.br'
      click_on 'Cadastrar'

      expect(current_path).to eq(user_registration_path)
      expect(page).to have_text('Não foi possível salvar aluno')
    end
  end

  context 'when fields have invalid values' do
    it 'user email must be unique to register' do
      user = Fabricate(:user)
      visit root_path
      first(:button, 'Nova Conta').click

      expect(current_path).to eq(new_user_registration_path)

      fill_in 'E-mail', with: user.email
      fill_in 'Senha', with: '12345678'
      fill_in 'Confirmar Senha', with: '12345678'
      click_on 'Cadastrar'

      expect(current_path).to eq(user_registration_path)
      expect(page).to have_text('Não foi possível salvar aluno')
    end

    it 'user password cant be less than eight characters long to register' do
      visit root_path
      first(:button, 'Nova Conta').click

      expect(current_path).to eq(new_user_registration_path)

      fill_in 'E-mail', with: 'john.doe@codesaga.com'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirmar Senha', with: ''
      click_on 'Cadastrar'

      expect(current_path).to eq(user_registration_path)
      expect(page).to have_text('Não foi possível salvar aluno')
    end
  end
end

describe 'user login' do
  context 'when signin with valid user' do
    it 'user can login' do
      user = Fabricate(:user)
      visit root_path
      click_on 'Entrar'

      expect(current_path).to eq(new_user_session_path)

      fill_in 'E-mail', with: user.email
      fill_in 'Senha', with: user.password

      click_on 'Login'

      expect(current_path).to eq(root_path)

      expect(page).to have_text('Login efetuado com sucesso!')
    end
  end

  context 'when signin with invalid values' do
    it 'user cannot login with empty email' do
      user = Fabricate(:user)
      visit root_path
      click_on 'Entrar'

      expect(current_path).to eq(new_user_session_path)

      fill_in 'Senha', with: user.password

      click_on 'Login'

      expect(current_path).to eq(user_session_path)
      expect(page).to have_text('E-mail ou senha inválida')
    end

    it 'user cannot login with empty password' do
      user = Fabricate(:user)
      visit root_path
      click_on 'Entrar'

      expect(current_path).to eq(new_user_session_path)

      fill_in 'E-mail', with: user.email

      click_on 'Login'

      expect(current_path).to eq(user_session_path)
      expect(page).to have_text('E-mail ou senha inválida')
    end

    it 'user cannot login with unregistered email' do
      visit root_path
      click_on 'Entrar'
      expect(current_path).to eq(new_user_session_path)

      fill_in 'E-mail', with: 'jhon.due@codesaga.com'
      fill_in 'Senha', with: '12345678'
      click_on 'Login'

      expect(current_path).to eq(user_session_path)
      expect(page).to have_text('E-mail ou senha inválida')
    end
  end

  context 'when user signout' do
    it 'user logout' do
      login_user

      visit user_session_path

      expect(current_path).to eq(root_path)

      expect(page).not_to have_text('Entrar')
      expect(page).not_to have_text('Cadastrar')

      find('#dropdownMenuButton1').click

      within '.dropdown-menu' do
        accept_confirm do
          click_on 'Sair'
        end
      end

      expect(current_path).to eq(root_path)
      expect(page).to have_button('Entrar')
      expect(page).to have_button('Nova Conta')
      expect(page).to have_text('Saiu com sucesso.')
    end
  end
end

describe 'user can change password' do
  context 'when user changes password' do
    it 'request reset password' do
      user = Fabricate(:user)

      visit user_session_path
      click_on 'Esqueceu sua senha?'
      expect(current_path).to eq(new_user_password_path)
      expect(page).to have_text('Esqueceu sua senha?')
      fill_in 'E-mail', with: user.email
      click_on 'Enviar instruções para redefinição da senha'

      expect(current_path).to eq(user_session_path)
      expect(page).to have_text('Dentro de minutos, você receberá um e-mail com instruções para a troca da sua senha.')
    end

    it 'create a new password' do
      user = Fabricate(:user)
      token = user.send_reset_password_instructions
      visit edit_user_password_path(reset_password_token: token)

      fill_in 'Nova senha', with: '1234567890'
      fill_in 'Confirmar nova senha', with: '1234567890'
      click_on 'Mudar minha senha'

      expect(page).to have_text('Sua senha foi alterada com sucesso. Você está logado.')
      expect(current_path).to eq(root_path)
    end
  end
end
