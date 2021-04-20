Fabricator(:admin) do
  email { sequence(:email) { |i| "admin#{i + 1}@codeplay.com.br" } }
  password '123456'
end
