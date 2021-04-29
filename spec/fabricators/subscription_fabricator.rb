Fabricator(:subscription) do
  name { "Jornada com #{Faker::ProgrammingLanguage.unique.name}" }
  description { Faker::Lorem.paragraph }
  price { Faker::Commerce.price(range: 50.00..400.00) }
end
