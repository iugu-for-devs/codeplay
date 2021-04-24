require 'rails_helper'

describe 'user billing option' do
	
	
	
	it 'user add billing option' do
		user = Fabricate(:user)
		login_as(user, scope: :user)
		visit user_profile_path
		click_on 'Meios de Pagamento'
		click_on 'Adicionar cartão de crédito'
		fill_in 'Numero do cartão', with: '4121 4444 1111 5815'
		fill_in 'Nome no cartão', with: 'John Doe '
		fill_in 'Data de expiração', with: '10/05/2021'
		fill_in 'Código de segurança', with: '777'

		click_on 'Cadastrar'

		byebug
   # token = SecureRandom.hex(20)

	#	allow(SecureRandom).to receive(:hex).and_return(user.token)


	end

end