require 'rails_helper'

describe 'View Subscriptions' do
  it 'user can see subscriptions plans' do
    subscription = Fabricate(:subscription)
    other_subscription = Fabricate(:subscription,
                                   name: 'Jornada Mobile com Dart e Flutter',
                                   description: 'Esta assinatura irá englobar todos os cursos'\
                                                'de Dart e o framework Flutter')

    visit root_path
    within 'li#subscriptions' do
      click_on 'Assinaturas'
    end
    expect(page).to have_text(subscription.name)
    expect(page).to have_text(subscription.description)
    expect(page).to have_text(other_subscription.name)
    expect(page).to have_text(other_subscription.description)
  end

  it 'can see footer in subscriptions page' do
    visit subscriptions_path

    within '.footer-section' do
      expect(page).to have_content('SOBRE A CODEPLAY')
      expect(page).to have_content('Nossa missão é propiciar educação online de qualidade!')
      find("img[alt='home']").click
      expect(current_path).to eq(root_path)
    end
  end
end
