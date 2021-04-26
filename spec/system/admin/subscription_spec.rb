require 'rails_helper'

describe 'Subscription plan' do
  it 'view all subscriptions plans' do
    admin = Fabricate(:admin)
    subscription = Fabricate(:subscription)
    other_subscription = Fabricate(:subscription,
                                   name: 'Jornada Mobile com Dart e Flutter',
                                   description: 'Esta assinatura irá englobar todos os cursos'\
                                                'de Dart e o framework Flutter')

    login_as admin, scope: :admin
    visit admin_subscriptions_path

    expect(page).to have_text(subscription.name)
    expect(page).to have_text(other_subscription.name)
  end

  it 'can view a subscription plan' do
    admin = Fabricate(:admin)
    subscription = Fabricate(:subscription)

    login_as admin, scope: :admin
    visit admin_subscriptions_path

    click_on subscription.name

    expect(page).to have_text(subscription.name)
    expect(page).to have_text(subscription.description)
    expect(page).to have_text(subscription.price)
  end

  it 'view a subscription plan and return to index' do

    admin = Fabricate(:admin)
    subscription = Fabricate(:subscription)

    login_as admin, scope: :admin
    visit admin_subscriptions_path
    click_on subscription.name
    click_on 'Planos'

    expect(current_path).to eq(admin_subscriptions_path)
  end

  it 'admin can create a subscription plan' do
    admin = Fabricate(:admin)
    login_as admin, scope: :admin

    visit admin_subscriptions_path
    click_on 'Cadastrar Plano'
    fill_in 'Nome', with: 'Jornada Web com Rails'
    fill_in 'Descrição', with: 'Esta assinatura irá englobar todos os cursos de Ruby e Rails'
    fill_in 'Preço', with: '50'
    click_on 'Criar Plano'

    expect(page).to have_text('Plano cadastrado com sucesso')
    expect(page).to have_text('Jornada Web com Rails')
    expect(page).to have_text('Esta assinatura irá englobar todos os cursos de Ruby e Rails')
    expect(page).to have_text('50')
  end

  it 'admin cannot create a subscription plan with blank attributes' do
    admin = Fabricate(:admin)
    login_as admin, scope: :admin

    visit admin_subscriptions_path
    click_on 'Cadastrar Plano'
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Preço', with: ''
    click_on 'Criar Plano'

    expect(page).to have_text('Nome não pode ficar em branco')
  end

  it 'admin access new subscription plan form and return to index' do
    admin = Fabricate(:admin)
    login_as admin, scope: :admin

    visit admin_subscriptions_path
    click_on 'Cadastrar Plano'
    click_on 'Planos'

    expect(current_path).to eq(admin_subscriptions_path)
  end

  it 'admin can add a course to a subscription' do
    admin = Fabricate(:admin)
    subscription = Fabricate(:subscription)
    course = Fabricate(:course)

    login_as admin, scope: :admin
    visit admin_subscription_path(subscription)
    fill_in 'Nome do curso', with: course.name
    click_on 'Buscar Curso'
    select course.name
    click_on 'Adicionar curso'

    expect(page).to have_text(course.name)
    expect(page).to have_text(course.description)
  end

  it 'admin cannot add same course to subscription' do
    admin = Fabricate(:admin)
    subscription = Fabricate(:subscription)
    course = Fabricate(:course)
    subscription.courses << course

    login_as admin, scope: :admin
    visit admin_subscription_path(subscription)
    fill_in 'Nome do curso', with: course.name
    click_on 'Buscar Curso'
    expect(page).to_not have_select('course_id', options: [course.name])
  end
end
