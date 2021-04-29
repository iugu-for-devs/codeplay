Fabricator(:text_lesson) do
  name { sequence(:name) { |i| "AulaTexto-##{i + 1}" } }
  description 'Isso é uma aula texto'
  lesson_body 'Lorem ipsum dolor sit amet consectetur.'
  course
end
