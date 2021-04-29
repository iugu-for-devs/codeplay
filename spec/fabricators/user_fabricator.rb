Fabricator(:user) do
  full_name 'John Doe'
  email { sequence(:email) { |i| "john.doe#{i}@iugu.com.br" } }
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
