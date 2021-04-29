require 'rails_helper'

RSpec.describe User, type: :model do
  context 'registration validation test' do
    it 'ensures full_name, email, password, address, cpf and birthdate presence' do
      user = User.create

      expect(user.errors[:full_name]).to include('não pode ficar em branco')
      expect(user.errors[:email]).to include('não pode ficar em branco')
      expect(user.errors[:password]).to include('não pode ficar em branco')
      expect(user.errors[:address]).to include('não pode ficar em branco')
      expect(user.errors[:cpf]).to include('não pode ficar em branco')
      expect(user.errors[:birthdate]).to include('não pode ficar em branco')
      expect(user).not_to be_valid
    end

    it 'ensures a new user is properly created' do
      user = User.create(full_name: 'Johnny Doe', email: 'johnny.doe@codesaga.com', password: '12345678',
                         password_confirmation: '12345678',
                         address: { street: 'Rua Bastião', number: '101',
                                    complement: 'casa 1', cep: '09941070', city: 'São Paulo', state: 'SP' },
                         birthdate: '08/08/1990', cpf: '00000000353')
      expect(user).to be_persisted
    end

    it 'ensures email is unique' do
      user = Fabricate(:user)
      new_user = Fabricate.build(:user, email: user.email)
      new_user.save
      expect(new_user.errors[:email]).to include('já está em uso')
    end
  end
end
