Fabricator(:user) do
  email { sequence(:email) { |i| "user#{i + 1}@test.com.br" } }
  password '123123'
end
