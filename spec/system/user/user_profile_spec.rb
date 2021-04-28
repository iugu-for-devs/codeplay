require 'rails_helper'

describe 'User' do
  it 'can view specific navbar when logged in' do
    client = Fabricate(:user)
    client.confirm

    login_as client, scope: :user

    visit root_path

    expect(page).to have_link('Home', href: root_path)
    expect(page).to have_link('Meu Perfil', href: user_profile_path)
    expect(page).to have_link('Cursos', href: courses_path)
    expect(page).to have_link('Assinaturas', href: subscriptions_path)
    expect(page).to have_link('Sair', href: destroy_user_session_path)

    expect(page).not_to have_link('Entrar', href: new_user_session_path)
    expect(page).not_to have_link('Nova Conta', href: new_user_registration_path)
  end

  it 'can view user profile' do
    client = Fabricate(:user)
    client.confirm

    login_as client, scope: :user

    visit root_path

    click_on 'Meu Perfil'

    expect(page).to have_text(client.email)
  end

  it 'can view user profile and only users email' do
    clients = Fabricate.times(2, :user)
    clients[0].confirm
    clients[1].confirm

    login_as clients[0], scope: :user

    visit root_path

    click_on 'Meu Perfil'

    expect(page).to have_text(clients[0].email)
    expect(page).not_to have_text(clients[1].email)
  end

  it 'user can view you profile and can see owned courses' do
    client = Fabricate(:user)
    client.confirm

    login_as client, scope: :user

    visit root_path
    click_on 'Meu Perfil'
    click_on 'Meus Cursos'

    expect(page).to have_text('Curso Avançado de Ruby')
    expect(page).to have_text('Curso de Ruby 1.0')
  end

  it 'user can view you profilea and can see owned subscriptions' do
    client = Fabricate(:user)
    client.confirm

    login_as client, scope: :user

    visit root_path
    click_on 'Meu Perfil'
    click_on 'Meus Planos'

    expect(page).to have_text('Jornada Web com Rails')
    expect(page).to have_text('Esta assinatura ira abranger todos os cursos de Ruby e Rails')
    expect(page).to have_text('50')
  end

  it 'user can view you profilea and can see orders history' do
    client = Fabricate(:user)
    client.confirm

    login_as client, scope: :user

    visit root_path
    click_on 'Meu Perfil'
    click_on 'Minhas Compras'

    expect(page).to have_text('PIX')
  end
end
