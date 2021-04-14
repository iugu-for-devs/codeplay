require 'rails_helper'

describe 'Subscription plan' do
  it 'view course plan' do
    Subscription.create!(name: 'Ruby', description: 'Curso básico de Ruby',
                         price: '50')
    Subscription.create!(name: 'Rails', description: 'Curso básico de Rails',
                         price: '80')

    visit subscriptions_path
    expect(page).to have_text ('Ruby')
    expect(page).to have_text ('Curso básico de Ruby')
    expect(page).to have_text ('50')
    expect(page).to have_text ('Rails')
    expect(page).to have_text ('Curso básico de Rails')
    expect(page).to have_text ('80')
  end

  it 'create a course plan' do
    visit subscription_path
    click_on 'Crir novo plano de assinatura'
    fill_in 'Name', with: 'Ruby'
    fill_in 'Descrição', with: 'Todos os cursos básicos de Ruby'
    fill_in 'Valor', with: '50'
    click_on 'Cadastrar'

    expect(current_path).to eq subscribe_plan_path
    expect(flah[:alert]).to have_text 'Plano cadastrado com sucesso'
  end
end
