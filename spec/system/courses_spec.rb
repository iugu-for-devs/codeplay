require 'rails_helper'

describe 'Course Management' do
  context 'Create' do
    it 'Can create a course' do
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
end
