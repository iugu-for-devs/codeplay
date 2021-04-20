Fabricator(:admin) do
  name { sequence(:name) { |i| "Admin #{i + 1}" } }
  email { sequence(:email) { |i| "admin#{i + 1}@codeplay.com.br" } }
  password '123456'
end
