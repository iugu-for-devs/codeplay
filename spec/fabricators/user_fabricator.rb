Fabricator(:user) do
  email { sequence(:email) { |i| "john.doe#{i}@iugu.com.br" } }
  password '12345678'
  confirmed_at nil
end
