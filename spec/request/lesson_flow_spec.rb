require 'rails_helper'

describe 'lessons', type: :request do
  it 'cannot view course details without login' do
    course = Fabricate(:course)

    get admins_course_path(course), params: { course: course.id }
    expect(response).to redirect_to(new_admin_session_path)
  end

  it 'cannot view lesson details without login' do
    lesson = Fabricate(:lesson)

    get admins_lesson_path(lesson)
    expect(response).to redirect_to(new_admin_session_path)
  end

  it 'creates a lesson' do
    login_as(Fabricate(:admin), scope: :admin)
    course = Fabricate(:course)
    post "/admins/courses/#{course.id}/lessons", params: { lesson: { name: 'Aula Ruby', description: 'Array em Ruby',
                                                                     video_code: '123123', course_id: course.id } }

    assert_redirected_to admins_lesson_path(id: Lesson.last.id)
    expect(Lesson.last).to be_valid
  end

  it 'cannot create without login' do
    course = Fabricate(:course)
    post "/admins/courses/#{course.id}/lessons", params: { lesson: { name: 'Aula Ruby', description: 'Array em Ruby',
                                                                     video_code: '123123', course_id: course.id } }

    expect(response).to redirect_to(new_admin_session_path)
  end

  it 'edit a lesson' do
    login_as(Fabricate(:admin), scope: :admin)
    Fabricate(:lesson, name: 'Aula Ruby', description: 'Array em Ruby', video_code: '123123')

    patch "/admins/lessons/#{Lesson.last.id}",
          params: { lesson: { name: 'Rails', description: 'Rotas', video_code: '111' } }

    assert_redirected_to admins_lesson_path(id: Lesson.last.id)
  end

  it 'cannot edit without login' do
    Fabricate(:lesson, name: 'Aula Ruby', description: 'Array em Ruby', video_code: '123123')

    patch "/admins/lessons/#{Lesson.last.id}",
          params: { lesson: { name: 'Rails', description: 'Rotas', video_code: '111' } }
    expect(response).to redirect_to(new_admin_session_path)
  end

  it 'delete a lesson' do
    course = Fabricate(:course)
    Fabricate(:lesson, course: course)

    login_as(Fabricate(:admin), scope: :admin)
    delete "/admins/lessons/#{Lesson.last.id}"
    expect(response).to redirect_to(admins_course_path(course))
  end

  it 'cannot destroy a lesson without login' do
    course = Fabricate(:course)
    Fabricate(:lesson, course: course)

    delete "/admins/lessons/#{Lesson.last.id}"
    expect(response).to redirect_to(new_admin_session_path)
  end
end
