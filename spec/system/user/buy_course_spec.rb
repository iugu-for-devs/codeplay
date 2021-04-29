require 'rails_helper'

describe 'Authenticated user buy course' do
  it 'in order view' do
    login_user
    course = Fabricate(:course)

    visit course_path(course)
    click_on 'Comprar'

    expect(page).to have_current_path(new_course_order_path(course))
  end

  context 'when status is approved' do
    it 'returns successfully with credit card' do
      returned_token = Faker::Alphanumeric.alphanumeric(number: 10)
      allow(Faraday).to receive(:post).and_return({ status: 'approved', token: returned_token })

      login_user
      course = Fabricate(:course)

      visit course_path(course)
      click_on 'Comprar'
      within 'form' do
        expect(page).to have_content('Forma de Pagamento')

        select 'Cartão de Crédito', from: 'Forma de Pagamento'
        click_on 'Efetuar Compra'
      end

      expect(page).to have_content('Compra realizada com sucesso!')
      expect(current_path).to eq(course_path(course))
    end

    it 'returns successfully with pix' do
      returned_token = Faker::Alphanumeric.alphanumeric(number: 10)
      allow(Faraday).to receive(:post).and_return({ status: 'approved', token: returned_token })
      login_user
      course = Fabricate(:course)

      visit course_path(course)
      click_on 'Comprar'

      within 'form' do
        select 'PIX', from: 'Forma de Pagamento'
        click_on 'Efetuar Compra'
      end

      expect(page).to have_content('Compra realizada com sucesso!')
      expect(current_path).to eq(course_path(course))
    end

    it 'returns successfully with boleto' do
      returned_token = Faker::Alphanumeric.alphanumeric(number: 10)
      allow(Faraday).to receive(:post).and_return({ status: 'approved', token: returned_token })
      login_user
      course = Fabricate(:course)

      visit course_path(course)
      click_on 'Comprar'

      within 'form' do
        select 'Boleto', from: 'Forma de Pagamento'
        click_on 'Efetuar Compra'
      end

      expect(page).to have_content('Compra realizada com sucesso!')
      expect(current_path).to eq(course_path(course))
    end
  end
end

describe 'Unauthenticated user' do
  it 'click on buy button' do
    course = Fabricate(:course)

    visit course_path(course)
    click_on 'Comprar'
    page.refresh

    expect(page).to have_current_path(new_user_session_path)
  end

  it 'loggin, visit course page and buy course' do
    returned_token = Faker::Alphanumeric.alphanumeric(number: 10)
    allow(Faraday).to receive(:post).and_return({ status: 'approved', token: returned_token })
    User.create!(email: 'test@gmail.com', password: '123456')
    course = Fabricate(:course)

    visit course_path(course)
    click_on 'Comprar'
    within 'form' do
      fill_in 'E-mail', with: 'test@gmail.com'
      fill_in 'Senha', with: '123456'
      click_on 'Log in'
    end

    within 'form' do
      select 'PIX', from: 'Forma de Pagamento'
      click_on 'Efetuar Compra'
    end

    expect(page).to have_content('Compra realizada com sucesso!')
    expect(current_path).to eq(course_path(course))
  end

  it 'visit course page, sign up and buy course' do
    returned_token = Faker::Alphanumeric.alphanumeric(number: 10)

    allow(Faraday).to receive(:post).and_return({ status: 'approved',
                                                  token: returned_token })
    course = Fabricate(:course)

    visit course_path(course)
    click_on 'Comprar'
    click_on 'Sign up'
    within 'form' do
      fill_in 'E-mail', with: 'test@gmail.com'
      fill_in 'Senha', with: '123456'
      fill_in 'Password confirmation', with: '123456'
      click_on 'Sign up'
    end

    within 'form' do
      select 'PIX', from: 'Forma de Pagamento'
      click_on 'Efetuar Compra'
    end

    expect(page).to have_content('Compra realizada com sucesso!')
    expect(current_path).to eq(course_path(course))
  end
end
