Fabricator(:course) do
  name        { sequence(:name) { |i| "Curso de Ruby #{i + 1}.0" } }
  description 'Curso Avançado de Ruby'
  cover 'covers/404.jpg'
  admin
end
