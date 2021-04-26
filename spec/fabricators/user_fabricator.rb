Fabricator(:user) do
  email { Faker::Internet.email }
  password '123456'
end
