require 'rails_helper'

describe 'text_lessons management' do
  it 'visit text_lesson details' do
    admin = Fabricate(:admin)
    course = Fabricate(:course)
    text_lessons = Fabricate.times(2, :text_lesson, course: course)

    login_as(admin, scope: :admin)
    visit admin_course_path(course)
    click_on text_lessons.first.name

    expect(page).to have_text(text_lessons.first.name)
    expect(page).to have_text(text_lessons.first.description)
    expect(page).to have_text('Lorem ipsum dolor sit amet consectetur.')
    expect(page).to_not have_text(text_lessons.second.name)
    expect(page).to have_css("a[href=\"#{admin_courses_path}\"]")
    expect(page).to have_css("a[href=\"#{admin_course_path(text_lessons.first.course.id)}\"]")
  end

  it 'view text lesson details and return to course' do
    admin = Fabricate(:admin)
    course = Fabricate(:course)
    text_lessons = Fabricate.times(5, :text_lesson, course: course)

    login_as(admin, scope: :admin)
    visit admin_course_path(course)
    click_on text_lessons.first.name
    click_on course.name

    expect(current_path).to eq(admin_course_path(course))
  end

  it 'cannot visit text lesson details without login' do
    course = Fabricate(:course)
    text_lesson = Fabricate(:text_lesson)

    visit admin_course_text_lesson_path(course, text_lesson)

    expect(page).to_not have_text(text_lesson.name)
    expect(current_path).to eq(new_admin_session_path)
  end

  it 'create a text lesson' do
    admin = Fabricate(:admin)
    course = Fabricate(:course)

    login_as(admin, scope: :admin)
    visit admin_course_path(course)
    click_on 'Cadastrar Aula Texto'
    fill_in 'Nome', with: 'Artigo de Herança'
    fill_in 'Descrição', with: 'Detalhando mais a Herança'
    fill_in_rich_text_area 'Conteúdo', with: 'Lorem ipsum dolor sit amet consectetur'
    click_on 'Criar Aula'

    expect(current_path).to eq(admin_course_text_lesson_path(course_id: TextLesson.last.course.id,
                                                             id: TextLesson.last.id))
    expect(page).to have_text('Artigo de Herança')
    expect(page).to have_text('Detalhando mais a Herança')
    expect(page).to have_text('Lorem ipsum dolor sit amet consectetur')
  end

  it 'cannot create a text lesson with blank params: name and video_code' do
    admin = Fabricate(:admin)
    course = Fabricate(:course)

    login_as(admin, scope: :admin)
    visit admin_course_path(course)
    click_on 'Cadastrar Aula Texto'
    fill_in 'Nome', with: ''
    fill_in_rich_text_area 'Conteúdo', with: ''
    click_on 'Criar Aula'

    expect(TextLesson.new).to_not be_valid
    expect(page).to have_text('não pode ficar em branco', count: 2)
  end

  it 'can edit text lesson' do
    admin = Fabricate(:admin)
    course = Fabricate(:course)
    text_lesson = Fabricate(:text_lesson, name: 'Artigo', description: 'Detalhando Herança',
                                          lesson_body: 'Artigo explicando herança', course: course)

    login_as(admin, scope: :admin)
    visit admin_course_text_lesson_path(course, text_lesson)
    click_on 'Editar Aula'
    fill_in 'Nome', with: 'Novo artigo'
    fill_in 'Descrição', with: 'Detalhando Guard Clause'
    fill_in_rich_text_area 'Conteúdo', with: 'Artigo explicando guard clause'
    click_on 'Atualizar Aula'

    expect(current_path).to eq(admin_course_text_lesson_path(course, text_lesson))
    expect(page).to have_text('Novo artigo')
    expect(page).to have_text('Detalhando Guard Clause')
    expect(page).to have_text('Artigo explicando guard clause')
  end

  it 'cannot update text lesson with blanks' do
    admin = Fabricate(:admin)
    course = Fabricate(:course)
    text_lesson = Fabricate(:text_lesson, course: course)

    login_as(admin, scope: :admin)
    visit admin_course_text_lesson_path(course, text_lesson)
    click_on 'Editar Aula'
    fill_in 'Nome', with: ''
    fill_in_rich_text_area 'Conteúdo', with: ''
    click_on 'Atualizar Aula'

    expect(page).to have_text('não pode ficar em branco', count: 2)
  end

  it 'deletes a text lesson' do
    admin = Fabricate(:admin)
    course = Fabricate(:course)
    text_lesson = Fabricate(:text_lesson, course: course)

    login_as(admin, scope: :admin)
    visit admin_course_text_lesson_path(course, text_lesson)
    click_on 'Apagar Aula'

    expect(current_path).to eq(admin_course_path(course))
    expect(page).to have_text("Aula #{text_lesson.name} apagada com sucesso")
    expect(page).to have_text('Nenhuma aula cadastrada')
  end
end
