Fabricator(:course) do
  name { "Curso de #{Faker::ProgrammingLanguage.unique.name}" }
  description { Faker::Lorem.paragraphs(number: 1) }
  price { Faker::Commerce.price(range: 50.00..400.00) }
  admin
end
