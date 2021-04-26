require 'rails_helper'

describe 'View lessons', type: :request do
  it 'non admin cannot view lessons' do
    course = Fabricate(:course)
    lesson = Fabricate(:lesson, course: course)
    get course_lesson_path(course, lesson)

    expect(response).to redirect_to(new_user_session_path)
  end
end
