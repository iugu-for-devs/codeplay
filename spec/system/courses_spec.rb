require 'rails_helper'

describe 'Course Management' do
  context 'New' do
    let(:user) { Fabricate(:user) }
    let(:admin) { Fabricate(:admin) }

    it 'Admins can view the create form' do
      login_as(admin, scope: :admin)

      visit new_course_path

      expect(page).to have_text('Nome')
      expect(page).to have_text('Descrição')
      expect(page).to have_text('Professor(es)')
      expect(page).to have_text('Endereço da capa')
      expect(page).to have_text('Requisito(s)')
    end

    it 'Guests cannot create' do
      visit new_course_path

      expect(current_path).to eq(new_admin_session_path)
      expect(page).to have_text('Para continuar, efetue login ou registre-se.')
    end

    it 'Users cannot create' do
      login_as(user, scope: :user)
      visit new_course_path

      expect(current_path).to eq(new_admin_session_path)
      expect(page).to have_text('Para continuar, efetue login ou registre-se.')
    end
  end

  context 'Create' do
    let(:admin) { Fabricate(:admin) }

    it 'Can create a course' do
      login_as(admin, scope: :admin)
      visit new_course_path

      fill_in 'Nome', with: 'Curso de RubyOnRails'
      fill_in 'Descrição', with: 'Curso de RubyOnRails para Iniciantes'
      click_on 'Cadastrar'

      expect(current_path).to eq(course_path(Course.last))
      expect(page).to have_text('Curso criado com sucesso.')
      expect(page).to have_text('Curso de RubyOnRails')
      expect(page).to have_text('Curso de RubyOnRails para Iniciantes')
    end

    it 'Attributes cannot be blank' do
      login_as(admin, scope: :admin)
      visit new_course_path

      fill_in 'Nome', with: ''
      fill_in 'Descrição', with: ''
      click_on 'Cadastrar'

      expect(page).to have_text('Nome não pode ficar em branco')
      expect(page).to have_text('Descrição não pode ficar em branco')
    end
  end

  context 'Show' do
    it 'Can view a course' do
      course = Fabricate(:course)

      visit course_path(course)
      expect(page).to have_text(course.name)
      expect(page).to have_text(course.description)
      expect(page).to have_link('Voltar')
    end
  end

  context 'Index' do
    it 'Can list all courses' do
      course_one = Fabricate(:course)
      course_two = Fabricate(:course)

      visit courses_path

      expect(page).to have_text(course_one.name)
      expect(page).to have_text(course_one.description)
      expect(page).to have_text(course_two.name)
      expect(page).to have_text(course_two.description)
    end
  end

  it 'visit courses index' do
    courses = Fabricate.times(3, :course)
    visit root_path
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

  it 'visit lesson' do
    course = Fabricate(:course)
    lessons = Fabricate.times(3, :lesson, course: course)
    visit course_path(course)
    click_on lessons.first.name

    expect(page).to have_text(lessons.first.name)
    expect(page).to have_text(lessons.first.description)
    expect(page).to have_css("iframe[src*='https://player.vimeo.com/video/#{lessons.first.video_code}']")
  end




end
