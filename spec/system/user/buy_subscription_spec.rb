require 'rails_helper'

describe 'Authenticated user buy subscription' do
  it 'in order view' do
    login_user
    subscription = Fabricate(:subscription)

    visit subscription_path(subscription)
    click_on 'Comprar'

    expect(page).to have_current_path(new_subscription_order_path(subscription))
  end

  context 'when status is approved' do
    it 'returns successfully with credit card' do
      returned_token = Faker::Alphanumeric.alphanumeric(number: 10)
      allow(Invoice).to receive(:get_request).and_return([{ status: 'approved', token: returned_token }])

      login_user
      subscription = Fabricate(:subscription)

      visit subscription_path(subscription)
      click_on 'Comprar'
      within 'form' do
        expect(page).to have_content('Forma de Pagamento')

        select 'Cartão de Crédito', from: 'Forma de Pagamento'
        click_on 'Efetuar Compra'
      end

      expect(page).to have_content('Compra realizada com sucesso!')
      expect(current_path).to eq(subscription_path(subscription))
    end

    it 'returns successfully with pix' do
      returned_token = Faker::Alphanumeric.alphanumeric(number: 10)
      allow(Invoice).to receive(:get_request).and_return([{ status: 'approved', token: returned_token }])
      login_user
      subscription = Fabricate(:subscription)

      visit subscription_path(subscription)
      click_on 'Comprar'

      within 'form' do
        select 'PIX', from: 'Forma de Pagamento'
        click_on 'Efetuar Compra'
      end

      expect(page).to have_content('Compra realizada com sucesso!')
      expect(current_path).to eq(subscription_path(subscription))
    end

    it 'returns successfully with boleto' do
      returned_token = Faker::Alphanumeric.alphanumeric(number: 10)
      allow(Invoice).to receive(:get_request).and_return([{ status: 'approved', token: returned_token }])
      login_user
      subscription = Fabricate(:subscription)

      visit subscription_path(subscription)
      click_on 'Comprar'

      within 'form' do
        select 'Boleto', from: 'Forma de Pagamento'
        click_on 'Efetuar Compra'
      end

      expect(page).to have_content('Compra realizada com sucesso!')
      expect(current_path).to eq(subscription_path(subscription))
    end
  end
end

describe 'Unauthenticated user' do
  it 'click on buy button' do
    subscription = Fabricate(:subscription)

    visit subscription_path(subscription)
    click_on 'Comprar'
    page.refresh

    expect(page).to have_current_path(new_user_session_path)
  end

  it 'loggin, visit course page and buy course' do
    returned_token = Faker::Alphanumeric.alphanumeric(number: 10)
    allow(Invoice).to receive(:get_request).and_return([{ status: 'approved', token: returned_token }])
    client = Fabricate(:user)
    subscription = Fabricate(:subscription)

    visit subscription_path(subscription)
    click_on 'Comprar'
    within 'form' do
      fill_in 'E-mail', with: client.email
      fill_in 'Senha', with: client.password
      click_on 'Login'
    end

    within 'form' do
      select 'PIX', from: 'Forma de Pagamento'
      click_on 'Efetuar Compra'
    end

    expect(page).to have_content('Compra realizada com sucesso!')
    expect(current_path).to eq(subscription_path(subscription))
  end

  it 'visit subscription page, sign up and buy course' do
    returned_token = Faker::Alphanumeric.alphanumeric(number: 10)

    allow(Invoice).to receive(:get_request).and_return([{ status: 'approved', token: returned_token }])
    subscription = Fabricate(:subscription)

    visit subscription_path(subscription)
    click_on 'Comprar'
    click_on 'Cadastrar'
    within 'form' do
      fill_in 'Nome completo', with: 'John Doe'
      fill_in 'E-mail', with: 'john.doe@codeplay.com.br'
      fill_in 'Senha', with: '12345678'
      fill_in 'Confirmar Senha', with: '12345678'
      fill_in 'Data de nascimento', with: '08/08/1990'
      fill_in 'CPF', with: '000.000.003-53'
      fill_in 'Rua', with: 'Av. Marechal Tito'
      fill_in 'Número', with: '36'
      fill_in 'Complemento', with: 'Apto 48'
      fill_in 'CEP', with: '08040-150'
      fill_in 'Cidade', with: 'São Paulo'
      fill_in 'Estado', with: 'SP'
      click_on 'Cadastrar'
    end

    within 'form' do
      select 'PIX', from: 'Forma de Pagamento'
      click_on 'Efetuar Compra'
    end

    expect(page).to have_content('Compra realizada com sucesso!')
    expect(current_path).to eq(subscription_path(subscription))
  end
end
