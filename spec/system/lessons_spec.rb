require 'rails_helper'

describe 'lessons management' do
  it 'view lessons index' do
    admin = Fabricate(:admin)
    course = Fabricate(:course)
    lessons = Fabricate.times(5, :lesson, course: course)

    login_as(admin, scope: :admin)
    visit admins_root_path
    click_on 'Gerenciar Cursos'
    click_on course.name

    expect(lessons.count).to eq(5)
    lessons.each do |lesson|
      expect(page).to have_text(lesson.name)
    end
  end

  it 'visit lesson details' do
    admin = Fabricate(:admin)
    course = Fabricate(:course)
    lessons = Fabricate.times(5, :lesson, course: course, video_code: 'ABC1')

    login_as(admin, scope: :admin)
    visit admins_course_path(course)
    click_on lessons.first.name

    expect(page).to have_text(lessons.first.name)
    expect(page).to have_text(lessons.first.description)
    expect(page).to_not have_text(lessons.second.name)

    expect(page).to have_css("iframe[src*='https://player.vimeo.com/video/#{lessons.first.video_code}']")
    expect(page).to have_css("a[href=\"#{admins_courses_path}\"]")
    expect(page).to have_css("a[href=\"#{admins_courses_path(lessons.first.course.id)}\"]")
  end

  it 'admin cannot visit lesson details without login' do
    lesson = Fabricate(:lesson)
    visit admins_lesson_path(lesson)

    expect(page).to_not have_text(lesson.name)
    expect(current_path).to eq(new_admin_session_path)
  end
end
