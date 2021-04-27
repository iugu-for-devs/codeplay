require 'rails_helper'

describe 'billing option' do
  it 'user add credit card' do
    user = Fabricate(:user)
    login_as(user, scope: :user)
    visit user_profile_path
    click_on 'Meios de Pagamento'
    click_on 'Adicionar cartão de crédito'
    fill_in 'Numero do cartão', with: '4121444411115815'
    fill_in 'Nome no cartão', with: 'John Doe'
    fill_in 'Data de expiração', with: '10/05/2021'
    fill_in 'Código de segurança', with: '777'
    click_on 'Cadastrar'

    expect(page).to have_text('5815')
    expect(page).to have_text('John Doe')
    expect(page).to have_text('2021-10-05')
  end

  it 'user delete a credit card' do
    user = Fabricate(:user)
    login_as(user, scope: :user)
    card = Fabricate(:card, user: user, last_digits: '4444')
    # user_info = PaymentMethods.new(token: '79EAECADCAE842154', user_name: 'John Doe', last_digits: '4151',
    #                    expiration_date: '15/7/2021', id: user.id)

    visit user_profile_path
    click_on 'Meios de Pagamento'

    within 'div#c4444' do
      click_on 'Remover'
    end

    expect(page).to have_text('Nenhum cartão cadastrado')
  end
end


