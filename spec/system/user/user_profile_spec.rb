require 'rails_helper'

describe 'User' do
  it 'can view specific navbar when logged in' do
    client = Fabricate(:user)

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

    login_as client, scope: :user

    visit root_path

    click_on 'Meu Perfil'

    expect(page).to have_text(client.email)
  end

  it 'can view user profile and only users email' do
    clients = Fabricate.times(2, :user)

    login_as clients[0], scope: :user

    visit root_path

    click_on 'Meu Perfil'

    expect(page).to have_text(clients[0].email)
    expect(page).not_to have_text(clients[1].email)
  end

  it 'user can view their profile and can see owned courses' do
    client = login_user
    course = Fabricate(:course)
    Fabricate(:order, course: course, user: client)

    visit root_path
    click_on 'Meu Perfil'
    click_on 'Meus Cursos'

    expect(page).to have_text(course.name)
    expect(page).to have_text(course.description)
  end

  it 'user can view their profile and can see owned subscriptions' do
    client = Fabricate(:user)
    subscription = Fabricate(:subscription)
    order = Fabricate(:order, subscription: subscription, user: client)

    login_as client, scope: :user

    visit root_path
    click_on 'Meu Perfil'
    click_on 'Meus Planos'

    expect(page).to have_text(subscription.name)
    expect(page).to have_text(subscription.description)
    expect(page).to have_text(subscription.price)
  end
end
