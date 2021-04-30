require 'rails_helper'

describe 'View text Lessons' do
  context 'click in conclusion text lesson button' do
    it 'check' do
      client = login_user
      course = Fabricate(:course)
      text_lessons = Fabricate.times(5, :text_lesson, course: course)
      text_lessons.each do |lesson|
        Fabricate(:text_lesson_status, user: client, text_lesson: lesson)
      end
      Fabricate(:order, user: client, course: course)

      visit course_text_lesson_path(course, text_lessons.first)

      expect(page).to have_content('Marcar como concluído')

      click_on 'Marcar como concluído'
      expect(page).to have_content('Concluído!')
    end

    it 'unchecked' do
      client = login_user
      course = Fabricate(:course)
      text_lessons = Fabricate.times(5, :text_lesson, course: course)
      text_lessons.each do |lesson|
        Fabricate(:text_lesson_status, user: client, text_lesson: lesson, status: 'done')
      end
      Fabricate(:order, user: client, course: course)

      visit course_text_lesson_path(course, text_lessons.last)

      expect(page).to have_content('Concluído!')

      click_on 'Concluído!'

      expect(page).to have_content('Marcar como concluído')
    end
  end

  context 'user can see if text lesson is already done' do
    it "visit text lessons and see if it's done" do
      client = login_user
      course = Fabricate(:course)

      text_lesson = Fabricate(:text_lesson, course: course)
      Fabricate(:text_lesson_status, user: client, text_lesson: text_lesson, status: 'done')

      other_text_lesson = Fabricate(:text_lesson, course: course)
      Fabricate(:text_lesson_status, user: client, text_lesson: other_text_lesson)

      Fabricate(:order, user: client, course: course)

      visit course_path(course)
      expect(text_lesson.text_lesson_status.first.status).to eq('done')
      expect(other_text_lesson.text_lesson_status.first.status).to eq('undone')
    end
  end

  context 'progress of a course' do
    it 'user can see the progress of the course' do
      client = login_user
      course = Fabricate(:course)

      text_lesson = Fabricate(:text_lesson, course: course)
      Fabricate(:text_lesson_status, user: client, text_lesson: text_lesson, status: 'done')

      other_text_lesson = Fabricate(:text_lesson, course: course)
      Fabricate(:text_lesson_status, user: client, text_lesson: other_text_lesson)
      Fabricate(:order, user: client, course: course)

      visit course_path(course)
      expect(page).to have_text('Progresso: 1/2')
    end
  end
end
