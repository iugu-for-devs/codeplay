Fabricator(:lesson) do
  name { sequence(:name) { |i| "Aula-##{i}" } }
  description 'Isso é uma aula'
  course
  video_code { sequence(:video_code) { |i| "ABC#{i}" } }
end
