require 'rails_helper'

describe 'Subscription plan' do
  it 'view all subscriptions plans' do
    Subscription.create!(name: 'Jornada Web com Rails',
                         description: 'Esta assinatura irá englobar todos os cursos de Ruby e Rails',
                         price: '50')
    Subscription.create!(name: 'Jornada Mobile com Dart e Flutter',
                         description: 'Esta assinatura irá englobar todos os cursos de Dart e o framework Flutter',
                         price: '80')

    visit subscriptions_path
    # TODO: colocar um within aqui, ta dando bug por alguma razao
    expect(page).to have_text('Jornada Web com Rails')
    expect(page).to have_text('Esta assinatura irá englobar todos os cursos de Ruby e Rails')
    expect(page).to have_text('Jornada Mobile com Dart e Flutter')
    expect(page).to have_text('Esta assinatura irá englobar todos os cursos de Dart e o framework Flutter')
  end

  it 'can view a subscription plan' do
    subscription = Fabricate(:subscription)

    visit subscriptions_path
    click_on 'Rails'

    expect(page).to have_text(subscription.name)
    expect(page).to have_text(subscription.description)
    expect(page).to have_text(subscription.price)
  end

  it 'view a subscription plan and return to index' do
    Fabricate(:subscription)

    visit subscriptions_path
    click_on 'Rails'
    click_on 'Voltar'

    expect(current_path).to eq(subscriptions_path)
  end

  it 'admin can create a subscription plan' do
    admin = Fabricate(:admin)
    login_as admin, scope: :admin

    visit subscriptions_path
    click_on 'Criar novo plano de assinatura'
    fill_in 'Nome', with: 'Jornada Web com Rails'
    fill_in 'Descrição', with: 'Esta assinatura irá englobar todos os cursos de Ruby e Rails'
    fill_in 'Valor', with: '50'
    click_on 'Cadastrar'

    expect(page).to have_text('Plano cadastrado com sucesso')
    expect(page).to have_text('Jornada Web com Rails')
    expect(page).to have_text('Esta assinatura irá englobar todos os cursos de Ruby e Rails')
    expect(page).to have_text('50')
  end

  it 'admin cannot create a subscription plan with blank attributes' do
    admin = Fabricate(:admin)
    login_as admin, scope: :admin

    visit subscriptions_path
    click_on 'Criar novo plano de assinatura'
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Valor', with: ''
    click_on 'Cadastrar'

    expect(page).to have_text('Nome não pode ficar em branco')
  end

  it 'admin access new subscription plan form and return to index' do
    admin = Fabricate(:admin)
    login_as admin, scope: :admin

    visit subscriptions_path
    click_on 'Criar novo plano de assinatura'
    click_on 'Voltar'

    expect(current_path).to eq(subscriptions_path)
  end

  it 'admin can add a course to a subscription' do
    admin = Fabricate(:admin)
    login_as admin, scope: :admin
    subscription = Fabricate(:subscription)
    course = Fabricate(:course)

    visit subscription_path(subscription)
    fill_in 'Nome do curso', with: course.name
    click_on 'Adicionar curso'

    expect(page).to have_text(course.name)
    expect(page).to have_text(course.description)
  end

  it 'admin cannot add non-existing course to a subscription' do
    admin = Fabricate(:admin)
    login_as admin, scope: :admin
    subscription = Fabricate(:subscription)

    visit subscription_path(subscription)
    fill_in 'Nome do curso', with: 'Ruby'
    click_on 'Adicionar curso'

    expect(page).to have_text('Curso não encontrado')
  end
end
