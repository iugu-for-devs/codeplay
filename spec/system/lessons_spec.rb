require 'rails_helper'

describe 'lessons management' do
  it 'view lessons index' do
    user = Fabricate(:user)
    course = Fabricate(:course)
    lessons = Fabricate.times(5, :lesson, course: course)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Ver Cursos'
    click_on course.name

    expect(lessons.count).to eq(5)
    lessons.each do |lesson|
      expect(page).to have_text(lesson.name)
    end
  end

  it 'visit lesson details' do
    user = Fabricate(:user)
    course = Fabricate(:course)
    lessons = Fabricate.times(5, :lesson, course: course, video_code: 'ABC1234')
    login_as(user, scope: :user)
    visit course_path(course)
    click_on lessons.first.name

    expect(page).to have_text(lessons.first.name)
    expect(page).to have_text(lessons.first.description)
    expect(page).to_not have_text(lessons.second.name)
    expect(page).to have_link('Voltar', href: course_path(course))
    expect(page).to have_css("iframe[src*='https://player.vimeo.com/video/#{lessons.first.video_code}']")
  end

  xit 'cannot visit lesson details without login' do
    # TODO
  end
end
