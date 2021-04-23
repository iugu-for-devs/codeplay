Fabricator(:user) do
  email { sequence(:email) { |i| "user#{i + 1}@gmail.com" } }
  password { '123456' }
  token { Faker::Alphanumeric.alphanumeric(number: 10) }
end
