require 'rails_helper'

describe 'has status approved' do
  it 'user can access course lessons' do
    client = login_user
    course = Fabricate(:course)
    course_lessons = Fabricate.times(5, :lesson, course: course)

    Fabricate(:order,
              user: client,
              course: course,
              status: 'approved')

    visit course_path(course)

    expect(page).to have_no_content('Comprar')

    expect(course_lessons.count).to eq(5)
    course_lessons.each do |lesson|
      expect(page).to have_content(lesson.name)
    end
  end

  it 'user can see the course in your course list' do
    client = login_user
    course = Fabricate(:course)
    Fabricate(:order,
              course: course,
              user: client,
              status: 'approved')

    visit user_courses_path(client)

    expect(page).to have_content(course.name)
    expect(page).to have_content(course.description)
  end
end
