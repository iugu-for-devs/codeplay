Fabricator(:admin) do
  email { sequence(:email) { |i| "admin#{i}@test.com.br" } }
  password '123123'
end
