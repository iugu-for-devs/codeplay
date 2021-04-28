require 'rails_helper'

describe 'Course Management' do
  it 'visit courses index' do
    courses = Fabricate.times(3, :course)
    visit root_path
    expect(page).to have_text('BOAS VINDAS AO CODEPLAY')
    click_on 'Ver Cursos'

    courses.each do |course|
      expect(page).to have_text(course.name)
    end
  end

  it 'visit course lessons' do
    course = Fabricate(:course)
    lessons = Fabricate.times(3, :lesson, course: course)
    visit course_path(course)

    lessons.each do |lesson|
      expect(page).to have_text(lesson.name)
    end
  end

  it 'visit video lesson with login' do
    user = Fabricate(:user)
    login_as(user, scope: :user)
    course = Fabricate(:course)
    lessons = Fabricate.times(3, :lesson, course: course)
    visit course_path(course)
    click_on lessons.first.name

    expect(page).to have_text(lessons.first.name)
    expect(page).to have_text(lessons.first.description)
    expect(page).to have_css("iframe[src*='https://player.vimeo.com/video/#{lessons.first.video_code}']")
  end

  it 'cannot visit video lesson without login' do
    course = Fabricate(:course)
    lessons = Fabricate.times(3, :lesson, course: course)

    visit course_lesson_path(course, lessons.first)

    expect(current_path).to eq(new_user_session_path)
  end

  it 'visit text lesson with login' do
    user = Fabricate(:user)
    login_as(user, scope: :user)
    course = Fabricate(:course)
    text_lessons = Fabricate.times(2, :text_lesson, course: course)
    visit course_path(course)
    click_on text_lessons.first.name

    expect(page).to have_text(text_lessons.first.name)
    expect(page).to have_text(text_lessons.first.description)
    expect(page).to have_text('Lorem ipsum dolor sit amet consectetur.')
  end

  it 'cannot visit text lesson without login' do
    course = Fabricate(:course)
    text_lessons = Fabricate.times(2, :text_lesson, course: course)

    visit course_text_lesson_path(course, text_lessons.first)
    expect(current_path).to eq(new_user_session_path)
  end
end
