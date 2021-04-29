require 'rails_helper'

describe 'Course Management' do
  context 'New' do
    let(:admin) { Fabricate(:admin) }

    it 'Admins can view the create form' do
      login_as(admin, scope: :admin)

      visit new_admin_course_path

      expect(page).to have_text('Nome')
      expect(page).to have_text('Descrição')
      expect(page).to have_text('Professor(es)')
      expect(page).to have_text('Endereço da capa')
      expect(page).to have_text('Token para Venda')
      expect(page).to have_text('Preço')
    end
  end

  context 'Create' do
    let(:admin) { Fabricate(:admin) }
    let(:user) { Fabricate(:user) }

    it 'Can create a course' do
      login_admin(admin)
      visit new_admin_course_path

      fill_in 'Nome', with: 'Curso de RubyOnRails'
      fill_in_rich_text_area 'Descrição', with: 'Curso de RubyOnRails para Iniciantes'
      click_on 'Cadastrar Curso'

      expect(current_path).to eq(admin_course_path(Course.last))
      expect(page).to have_text('Curso criado com sucesso.')
      expect(page).to have_text('Curso de RubyOnRails')
      expect(page).to have_text('Curso de RubyOnRails para Iniciantes')
    end

    it 'Attributes cannot be blank' do
      login_as(admin, scope: :admin)
      visit new_admin_course_path

      fill_in 'Nome', with: ''
      fill_in_rich_text_area 'Descrição', with: ''
      click_on 'Cadastrar Curso'

      expect(page).to have_text('Nome não pode ficar em branco')
      expect(page).to have_text('Descrição não pode ficar em branco')
    end

    it 'Guests cannot create' do
      visit new_admin_course_path

      expect(current_path).to eq(new_admin_session_path)
      expect(page).to have_text('Para continuar, efetue login ou registre-se.')
    end

    it 'Users cannot create' do
      login_as(user, scope: :user)
      visit new_admin_course_path

      expect(current_path).to eq(new_admin_session_path)
      expect(page).to have_text('Para continuar, efetue login ou registre-se.')
    end
  end

  context 'Show' do
    it 'Can view a course' do
      course = Fabricate(:course)

      visit course_path(course)
      expect(page).to have_text(course.name)
      expect(page).to have_text(course.description.to_plain_text)
    end
  end

  context 'Index' do
    it 'Can list all courses' do
      courses = Fabricate.times(2, :course)

      visit courses_path

      courses.each do |course|
        expect(page).to have_text(course.name)
        expect(page).to have_text(course.description.to_plain_text)
      end
    end
  end
end
