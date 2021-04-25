require 'rails_helper'

describe 'Home page' do
  describe 'Unauthenticated user' do
    context 'header' do
      it 'can see link buttons' do
        visit root_path

        expect(page).to have_link('Home', href: root_path)
        expect(page).to have_link('Cursos', href: courses_path)
        expect(page).to have_link('Assinaturas', href: subscriptions_path)
      end

      # it 'can see company logo' do
      #   visit root_path

      #   expect(page).to have_css("img[src*='logo-codeplay-black.svg']")
      # end

      it 'can see login button' do
        visit root_path

        click_on 'Entrar'
        expect(current_path).to eq(new_user_session_path)
      end

      it 'can see sign up button' do
        visit root_path

        click_on 'Nova Conta'
        expect(current_path).to eq(new_user_registration_path)
      end
    end

    context 'intro content' do
      it 'can see call text' do
        visit root_path

        within '.intro-content' do
          expect(page).to have_content('Junte-se à Milhares, Aprenda a Codar com a CodePlay.')
          expect(page).to have_content('Aprender de verdade é aqui! Escolhe entre vários Cursos e Assinaturas.')
        end
      end

      it 'can see quick registration form' do
        visit root_path

        within '.intro-content form' do
          expect(page).to have_content('Cadastrar')
        end
      end

      it 'can registration form' do
        visit root_path

        within '.intro-content form' do
          fill_in 'E-mail', with: 'test@gmail.com'
          fill_in 'Senha', with: '123456789'
          fill_in 'Confirmar Senha', with: '123456789'
          click_on 'Nova Conta'
        end

        expect(page).to have_content('Bem-vindo à CodePlay.')
        expect(page).to have_no_selector('div.intro-content')
        expect(current_path).to eq(root_path)
      end

      it 'can see button to see some courses' do
        visit root_path

        within '.intro-content' do
          expect(page).to have_link('Veja alguns cursos')
          click_on('Veja alguns cursos')
        end
        expect(current_path).to eq(courses_path)
      end
    end

    context 'courses section' do  
      let!(:courses) { Fabricate.times(6, :course) }

      it 'can see buttons control carousel' do
        visit root_path 

        page.execute_script "window.scrollBy(0,10000)"
        
        within '.courses-section' do
          expect(page).to have_content('Anterior')
          expect(page).to have_content('Próximo')
        end
      end

      it 'can be seen a carousel with some courses' do
        visit root_path

        page.execute_script "window.scrollBy(0,10000)"

        within '.courses-section' do
          courses.each do |course|
            expect(page).to have_content(course.name)
            click_on('Próximo')
          end

          expect(page).to have_css(".course", :count => 3)
        end
      end
        
      it 'can see prices' do
        visit root_path

        page.execute_script "window.scrollBy(0,10000)"
        
        within '.courses-section' do
          courses.each do |course|
            expect(page).to have_content(course.price)
            click_on('Próximo')
          end
        end
      end

      it 'can see names and descriptions' do
        visit root_path
        
        page.execute_script "window.scrollBy(0,10000)"

        within '.courses-section' do
          courses.each do |course|
            expect(page).to have_content(course.name)
            expect(page).to have_content(course.description)
            click_on('Próximo')
          end
        end
      end

      it 'can see number of lessons' do
        courses.each do |course|
          Fabricate.times(7,:lesson, course: course )
        end

        visit root_path

        page.execute_script "window.scrollBy(0,10000)"
        
        within  '.courses-section' do
          courses.each do |course| 
            expect(page).to have_content("#{course.lessons.size} Aulas")
            click_on('Próximo')
          end
        end
      end
    end
  end
end
