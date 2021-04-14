Fabricator(:lesson) do
  name { sequence(:name) { |i| "Aula-##{i}" } }
  description 'Isso é uma aula'
  course
end
