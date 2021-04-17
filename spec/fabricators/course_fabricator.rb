Fabricator(:course) do
  name { sequence(:name) { |i| "Curso-##{i + 1}" } }
  description 'Isso é um curso'
end
