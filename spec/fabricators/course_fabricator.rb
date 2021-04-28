Fabricator(:course) do
  name { "Curso de #{Faker::ProgrammingLanguage.unique.name}" }
  description { Faker::Lorem.paragraph }
  price { Faker::Commerce.price(range: 50.00..400.00) }
  token { Faker::Alphanumeric.alphanumeric(number: 10) }
  admin
end
