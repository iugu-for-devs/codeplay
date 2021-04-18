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

  it 'view no lessons avaible' do
    admin = Fabricate(:admin)
    course = Fabricate(:course)

    login_as(admin, scope: :admin)
    visit admins_course_path(course)

    expect(page).to have_text('Nenhuma aula cadastrada')
  end

  it 'cannot visit lessons index without login' do
    course = Fabricate(:course)
    Fabricate.times(3, :lesson, course: course)

    visit admins_course_path(course)

    course.lessons.each do |lesson|
      expect(page).to_not have_text(lesson.name)
    end
    expect(current_path).to eq(new_admin_session_path)
  end

  it 'visit lesson details' do
    admin = Fabricate(:admin)
    course = Fabricate(:course)
    lessons = Fabricate.times(5, :lesson, course: course)

    login_as(admin, scope: :admin)
    visit admins_course_path(course)
    click_on lessons.first.name

    expect(page).to have_text(lessons.first.name)
    expect(page).to have_text(lessons.first.description)
    expect(page).to_not have_text(lessons.second.name)

    expect(page).to have_css("iframe[src*='https://player.vimeo.com/video/#{lessons.first.video_code}']")
    expect(page).to have_css("a[href=\"#{admins_courses_path}\"]")
    expect(page).to have_css("a[href=\"#{admins_course_path(lessons.first.course.id)}\"]")
  end

  it 'view lesson details and return to course' do
    admin = Fabricate(:admin)
    course = Fabricate(:course)
    lessons = Fabricate.times(5, :lesson, course: course)

    login_as(admin, scope: :admin)
    visit admins_course_path(course)
    click_on lessons.first.name
    click_on course.name

    expect(current_path).to eq(admins_course_path(course))
  end

  it 'cannot visit lesson details without login' do
    lesson = Fabricate(:lesson)
    visit admins_lesson_path(lesson)

    expect(page).to_not have_text(lesson.name)
    expect(current_path).to eq(new_admin_session_path)
  end

  it 'create a lesson' do
    admin = Fabricate(:admin)
    course = Fabricate(:course)

    login_as(admin, scope: :admin)
    visit admins_course_path(course)
    click_on 'Cadastrar aula'
    fill_in 'Nome', with: 'Arrays em Ruby'
    fill_in 'Descrição', with: 'Novos métodos de Array'
    fill_in 'Código do Video', with: '1234'
    click_on 'Criar Aula'

    expect(current_path).to eq(admins_lesson_path(Lesson.last))
    expect(page).to have_text('Arrays em Ruby')
    expect(page).to have_text('Novos métodos de Array')
    expect(page).to have_css("iframe[src*='https://player.vimeo.com/video/1234']")
  end

  it 'cannot create a lesson with blank params: name and video_code' do
    admin = Fabricate(:admin)
    course = Fabricate(:course)

    login_as(admin, scope: :admin)
    visit admins_course_path(course)
    click_on 'Cadastrar aula'
    fill_in 'Nome', with: ''
    fill_in 'Código do Video', with: ''
    click_on 'Criar Aula'
    expect(Lesson.new).to_not be_valid
    expect(page).to have_text('não pode ficar em branco', count: 2)
  end

  it 'cannot create a lesson, vide_code must be unique' do
    admin = Fabricate(:admin)
    course = Fabricate(:course)
    Fabricate(:lesson, course: course, name: 'Aula1', video_code: '1234')

    login_as(admin, scope: :admin)
    visit admins_course_path(course)
    click_on 'Cadastrar aula'
    fill_in 'Nome', with: 'Aula1'
    fill_in 'Código do Video', with: '1234'
    click_on 'Criar Aula'
    expect(Lesson.new).to_not be_valid
    expect(page).to have_text('deve ser único', count: 1)
  end

  it 'can edit lesson' do
    admin = Fabricate(:admin)
    course = Fabricate(:course)
    lesson = Fabricate(:lesson, name: 'Aula1', description: 'Descrição de aula', video_code: '1234', course: course)

    login_as(admin, scope: :admin)
    visit admins_lesson_path(lesson)
    click_on 'Editar Aula'
    fill_in 'Nome', with: 'Ruby on Rails'
    fill_in 'Descrição', with: 'Aula de Rotas'
    fill_in 'Código do Video', with: '34563456'
    click_on 'Atualizar Aula'

    expect(current_path).to eq(admins_lesson_path(lesson))
    expect(page).to have_text('Ruby on Rails')
    expect(page).to have_text('Aula de Rotas')
    expect(page).to have_css("iframe[src*='https://player.vimeo.com/video/34563456']")
  end

  it 'cannot update lesson with blanks' do
    admin = Fabricate(:admin)
    course = Fabricate(:course)
    lesson = Fabricate(:lesson, course: course)

    login_as(admin, scope: :admin)
    visit admins_lesson_path(lesson)
    click_on 'Editar Aula'
    fill_in 'Nome', with: ''
    fill_in 'Código do Video', with: ''
    click_on 'Atualizar Aula'

    expect(page).to have_text('não pode ficar em branco', count: 2)
  end

  it 'cannot update lesson with repeated video_code' do
    admin = Fabricate(:admin)
    Fabricate(:lesson, video_code: '1234')
    lesson = Fabricate(:lesson)

    login_as(admin, scope: :admin)
    visit admins_lesson_path(lesson)
    click_on 'Editar Aula'
    fill_in 'Código do Video', with: '1234'
    click_on 'Atualizar Aula'

    expect(page).to have_text('deve ser único', count: 1)
  end

  it 'deletes a lesson' do
    admin = Fabricate(:admin)
    course = Fabricate(:course)
    lesson = Fabricate(:lesson, course: course)

    login_as(admin, scope: :admin)
    visit admins_lesson_path(lesson)
    click_on 'Apagar Aula'

    expect(current_path).to eq(admins_course_path(course))
    expect(page).to have_text("Aula #{lesson.name} apagada com sucesso")
    expect(page).to have_text('Nenhuma aula cadastrada')
  end
end
