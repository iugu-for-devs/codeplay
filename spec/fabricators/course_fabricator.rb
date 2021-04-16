Fabricator(:course) do
  name { sequence(:name) { |i| "Curso-##{i}" } }
  description 'Isso é um curso'
end
