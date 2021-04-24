require 'rails_helper'

describe 'Home page' do
	
	describe 'Unauthenticated user' do 
		context 'header' do 
			it 'can see link buttons' do
				visit root_path

				within '.header' do
					expect(page).to have_link('Home', href: root_path)
					expect(page).to have_link('Cursos', href: courses_path)
					expect(page).to have_link('Assinaturas', href: subscriptions_path)
					expect(page).to have_link('Entrar', href: new_user_session)
					expect(page).to have_link('Nova Conta', href: new_user_registration)
				end
			end

			it 'can see company logo' do
				visit root_path

				within '.logo' do 
					expect(page).to have_css("img[src*='logo-code-play.jpg']")
				end
			end
		end
	end
end