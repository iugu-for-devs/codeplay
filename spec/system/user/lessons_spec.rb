require 'rails_helper'

describe 'View Lessons' do
  # TODO
  xit 'visit text lesson with login but can not see' do
    login_as(user)
    course = Fabricate(:course)
    text_lessons = Fabricate.times(2, :text_lesson, course: course)
    visit course_path(course)
    
    click_on text_lessons.first.name

    expect(page).to have_text(text_lessons.first.name)
    expect(page).to have_text(text_lessons.first.description)
    expect(page).to have_text('Lorem ipsum dolor sit amet consectetur.')
  end

  xit 'cannot visit text lesson without login' do
    course = Fabricate(:course)
    text_lessons = Fabricate.times(2, :text_lesson, course: course)

    visit course_text_lesson_path(course, text_lessons.first)
    expect(current_path).to eq(new_user_session_path)
  end
end
