Fabricator(:lesson) do
  name { sequence(:name) { |i| "Aula-##{i + 1}" } }
  description 'Isso é uma aula'
  course
  video_code { sequence(:video_code) { |i| "ABC#{i + 1}" } }
end
