require 'rails_helper'

describe 'Authenticated user buy course' do
  it 'in order view' do
    client = User.create!(email: 'test@gmail.com', password: '123456')
    login_as client, scope: :user
    course = Course.create!(name: 'Ruby on Rails',
                            description: 'Pariatur sint laborum consectetur exercitation do tempor \
                                          aliqua ipsum nisi tempor cupidatat in ex.')

    visit course_path(course)
    click_on 'Comprar'
    
    expect(page).to have_current_path(new_order_path(course: course))
  end

  context 'when pay_type is selected' do
    it 'returns successfully with credit card' do
      client = User.create!(email: 'test@gmail.com', password: '123456')
      login_as client, scope: :user
      course = Course.create!(name: 'Ruby on Rails',
                              description: 'Pariatur sint laborum consectetur exercitation do tempor \
                                            aliqua ipsum nisi tempor cupidatat in ex.')

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
      client = User.create!(email: 'test@gmail.com', password: '123456')
      login_as client, scope: :user
      course = Course.create!(name: 'Ruby on Rails',
                              description: 'Pariatur sint laborum consectetur exercitation do tempor \
                                            aliqua ipsum nisi tempor cupidatat in ex.')

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
      client = User.create!(email: 'test@gmail.com', password: '123456')
      login_as client, scope: :user
      course = Course.create!(name: 'Ruby on Rails',
                              description: 'Pariatur sint laborum consectetur exercitation do tempor \
                                            aliqua ipsum nisi tempor cupidatat in ex.')

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

  context 'when pay_type is not selected' do
    it 'returns message error' do
      client = User.create!(email: 'test@gmail.com', password: '123456')
      login_as client, scope: :user
      course = Course.create!(name: 'Ruby on Rails',
                              description: 'Pariatur sint laborum consectetur exercitation do tempor \
                                            aliqua ipsum nisi tempor cupidatat in ex.')

      visit course_path(course)
      click_on 'Comprar'

      within 'form' do
        click_on 'Efetuar Compra'
      end

      expect(page).to have_content('Forma de Pagamento não pode ficar em branco')
      expect(page).to have_current_path(orders_path(course: course.id))
    end
  end
end

describe 'Unauthenticated user' do
  it 'click on buy button' do

    course = Course.create!(name: 'Ruby on Rails',
                            description: 'Pariatur sint laborum consectetur exercitation do tempor \
                                          aliqua ipsum nisi tempor cupidatat in ex.')

    visit course_path(course)
    click_on 'Comprar'
    page.refresh

    expect(page).to have_current_path(new_user_session_path)
  end

  it 'loggin, visit course page and buy course' do
    client = User.create!(email: 'test@gmail.com', password: '123456')
    course = Course.create!(name: 'Ruby on Rails',
                            description: 'Pariatur sint laborum consectetur exercitation do tempor \
                                          aliqua ipsum nisi tempor cupidatat in ex.')

    visit course_path(course)
    click_on 'Comprar'
    
    within 'form' do
      fill_in 'Email', with: 'test@gmail.com'
      fill_in 'Password', with: '123456'
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
    course = Course.create!(name: 'Ruby on Rails',
                            description: 'Pariatur sint laborum consectetur exercitation do tempor \
                                          aliqua ipsum nisi tempor cupidatat in ex.')

    visit course_path(course)
    click_on 'Comprar'
    click_on 'Sign up'
    within 'form' do
      fill_in 'Email', with: 'test@gmail.com'
      fill_in 'Password', with: '123456'
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