require 'rails_helper'

describe 'lessons', type: :request do
  it 'creates a lesson' do
    login_as(Fabricate(:admin), scope: :admin)
    course = Fabricate(:course)

    post "/admin/courses/#{course.id}/lessons", params: { lesson: Fabricate.attributes_for(:lesson, course: course) }

    lesson = Lesson.last
    assert_redirected_to admin_course_lesson_path(course, lesson)
    follow_redirect!
    expect(response).to have_http_status(:ok)
    expect(lesson).to be_valid
    expect(response.body).to include(lesson.name, lesson.description, lesson.video_code)
  end

  it 'cannot create without login' do
    course = Fabricate(:course)

    post "/admin/courses/#{course.id}/lessons", params: { lesson: Fabricate.attributes_for(:lesson, course: course) }

    expect(response).to redirect_to(new_admin_session_path)
  end

  it 'edit a lesson' do
    login_as(Fabricate(:admin), scope: :admin)
    course = Fabricate(:course)
    lesson = Fabricate(:lesson, course: course)

    patch "/admin/courses/#{course.id}/lessons/#{lesson.id}",
          params: { lesson: { name: 'Rails', description: 'Rotas', video_code: '111' } }

    assert_redirected_to admin_course_lesson_path(id: lesson.id)
    follow_redirect!
    expect(response.body).to include('Rails', 'Rotas', '111')
    expect(response.body).to include('Aula atualizada com sucesso')
    expect(response).to have_http_status(:ok)
  end

  it 'cannot edit without login' do
    course = Fabricate(:course)
    lesson = Fabricate(:lesson, course: course)

    patch "/admin/courses/#{course.id}/lessons/#{lesson.id}",
          params: { lesson: { name: 'Rails', description: 'Rotas', video_code: '111' } }

    expect(response).to redirect_to(new_admin_session_path)
  end

  it 'delete a lesson' do
    course = Fabricate(:course)
    lesson = Fabricate(:lesson, course: course)

    login_as(Fabricate(:admin), scope: :admin)
    delete "/admin/courses/#{course.id}/lessons/#{lesson.id}"

    expect(response).to redirect_to(admin_course_path(course))
    follow_redirect!
    expect(response).to have_http_status(:ok)
  end

  it 'cannot destroy a lesson without login' do
    course = Fabricate(:course)
    lesson = Fabricate(:lesson, course: course)

    delete "/admin/courses/#{course.id}/lessons/#{lesson.id}"

    expect(response).to redirect_to(new_admin_session_path)
  end
end
