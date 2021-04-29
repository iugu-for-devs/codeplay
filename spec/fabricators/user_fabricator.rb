Fabricator(:user) do
  full_name { sequence(:full_name) { |i| "User #{i}" } }
  email { sequence(:email) { |i| "user#{i}@gmail.com" } }
  password '12345678'
  birthdate '18/12/2220'
  cpf '00000000353'
  address "{
            'zipcode': '08040150',
            'number': '36',
            'street': 'Av. Marechal Tito',
            'complement': 'Apto 48',
            'state': 'SP',
            'city': 'São Paulo'
          }"
end
