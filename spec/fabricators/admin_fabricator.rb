Fabricator(:admin) do
  email { sequence(:email) { |i| "admin#{i + 1}@test.com.br" } }
  password '123123'
end
