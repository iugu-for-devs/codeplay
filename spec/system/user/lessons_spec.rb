require 'rails_helper'

describe 'View Lessons' do

  context 'click in conclusion lesson button' do
    it 'check' do
      client = login_user
      course = Fabricate(:course)
      lessons = Fabricate.times(5, :lesson, course: course)
      Fabricate(:order, user: client, course: course)

      visit course_lesson_path( course, lessons.first )

      expect(page).to have_content('Marcar como concluído')

      click_on 'Marcar como concluído'

      page.refresh

      expect(page).to have_content('Concluído!')
    end

    it 'unchecked' do
      client = login_user
      course = Fabricate(:course)
      lessons = Fabricate.times(5, :lesson, course: course, done: "check")
      Fabricate(:order, user: client, course: course)

      visit course_lesson_path( course, lessons.last )

      expect(page).to have_content('Concluído!')

      click_on 'Concluído!'

      page.refresh

      expect(page).to have_content('Marcar como concluído')
    end
  end
end
