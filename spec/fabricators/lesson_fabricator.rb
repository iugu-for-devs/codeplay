Fabricator(:lesson) do
  name { sequence(:name) { |i| "AulaVideo-##{i + 1}" } }
  description 'Isso é uma aula video'
  course
  video_code { sequence(:video_code) { |i| "ABC#{i + 1}" } }
end
