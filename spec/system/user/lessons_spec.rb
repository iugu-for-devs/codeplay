require 'rails_helper'

describe 'View Lessons' do
  context 'click in conclusion lesson button' do
    it 'check' do
      client = login_user
      course = Fabricate(:course)
      lessons = Fabricate.times(5, :lesson, course: course)
      Fabricate(:order, user: client, course: course)

      visit course_lesson_path(course, lessons.first)

      expect(page).to have_content('Marcar como concluído')

      click_on 'Marcar como concluído'
      expect(page).to have_content('Concluído!')
    end

    it 'unchecked' do
      client = login_user
      course = Fabricate(:course)
      lessons = Fabricate.times(5, :lesson, course: course, done: 'check')
      Fabricate(:order, user: client, course: course)

      visit course_lesson_path(course, lessons.last)

      expect(page).to have_content('Concluído!')

      click_on 'Concluído!'

      expect(page).to have_content('Marcar como concluído')
    end
  end

  context 'user can see if lesson is already done' do
    it "visit lessons and see if it's done" do
      client = login_user
      course = Fabricate(:course)
      lesson = Fabricate(:lesson, course: course)
      other_lesson = Fabricate(:lesson, course: course)
      Fabricate(:order, user: client, course: course)

      visit course_path(course)
      expect(lesson.done).to eq('check')
      expect(other_lesson.done).to eq('uncheck')
    end
  end

  context 'progress of a course' do
    it 'user can see the progress of the course' do
      client = login_user
      course = Fabricate(:course)
      lesson = Fabricate(:lesson, course: course)
      other_lesson = Fabricate(:lesson, course: course)
      Fabricate(:order, user: client, course: course)

      expect(page).to have_text('Progresso: 1/2')
    end
  end
end
