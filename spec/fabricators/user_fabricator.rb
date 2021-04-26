Fabricator(:user) do
  email { Faker::Internet.email }
  password '123456'
  token { Faker::Alphanumeric.alphanumeric(number: 10) }
end
