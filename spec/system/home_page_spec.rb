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

			it 'can see company logo' do
				visit root_path

				expect(page).to have_css("img[src*='logo-codeplay-black.svg']")
			end

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
	end
end