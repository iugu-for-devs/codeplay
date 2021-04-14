Fabricator(:user) do
  email { sequence(:email) { |i| "user#{i}@test.com.br" } }
  password '123123'
end
