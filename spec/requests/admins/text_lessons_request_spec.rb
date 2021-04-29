require 'rails_helper'

describe 'text_lessons', type: :request do
  it 'creates a text lesson' do
    login_as(Fabricate(:admin), scope: :admin)
    course = Fabricate(:course)

    post "/admin/courses/#{course.id}/text_lessons", params: { text_lesson:
                                                              Fabricate.attributes_for(:text_lesson, course: course) }

    text_lesson = TextLesson.last
    assert_redirected_to admin_course_text_lesson_path(course, text_lesson)
    follow_redirect!
    expect(response).to have_http_status(:ok)
    expect(text_lesson).to be_valid
    expect(response.body).to include(text_lesson.name, text_lesson.description, text_lesson.lesson_body.to_plain_text)
  end

  it 'cannot create text lesson without login' do
    course = Fabricate(:course)

    post "/admin/courses/#{course.id}/text_lessons", params: { text_lesson:
                                                              Fabricate.attributes_for(:text_lesson, course: course) }

    expect(response).to redirect_to(new_admin_session_path)
  end

  it 'edit a text lesson' do
    login_as(Fabricate(:admin), scope: :admin)
    course = Fabricate(:course)
    text_lesson = Fabricate(:text_lesson, course: course)

    patch "/admin/courses/#{course.id}/text_lessons/#{text_lesson.id}",
          params: { text_lesson: { name: 'Artigo', description: 'Descrição Artigo', lesson_body: 'Corpo do Artigo' } }

    assert_redirected_to admin_course_text_lesson_path(id: text_lesson.id)
    follow_redirect!
    expect(response.body).to include('Artigo', 'Descrição Artigo', 'Corpo do Artigo')
    expect(response.body).to include('Aula atualizada com sucesso')
    expect(response).to have_http_status(:ok)
  end

  it 'cannot edit text lesson without login' do
    course = Fabricate(:course)
    text_lesson = Fabricate(:text_lesson, course: course)

    patch "/admin/courses/#{course.id}/text_lessons/#{text_lesson.id}",
          params: { text_lesson: { name: 'Artigo', description: 'Descrição Artigo', lesson_body: 'Corpo do Artigo' } }

    expect(response).to redirect_to(new_admin_session_path)
  end

  it 'delete a text lesson' do
    course = Fabricate(:course)
    text_lesson = Fabricate(:text_lesson, course: course)

    login_as(Fabricate(:admin), scope: :admin)
    delete "/admin/courses/#{course.id}/text_lessons/#{text_lesson.id}"

    expect(response).to redirect_to(admin_course_path(course))
    follow_redirect!
    expect(response).to have_http_status(:ok)
  end

  it 'cannot destroy a text lesson without login' do
    course = Fabricate(:course)
    text_lesson = Fabricate(:text_lesson, course: course)

    delete "/admin/courses/#{course.id}/text_lessons/#{text_lesson.id}"

    expect(response).to redirect_to(new_admin_session_path)
  end
end
