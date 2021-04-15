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

    #xit 'Attributes cannot be blank' do
    #  visit new_course_path
    
    #  fill_in 'Nome', with: ''
    #  fill_in 'Descrição', with: ''
    #  click_on 'Cadastrar'
    #  binding.pry
    #  expect(current_path).to eq(new_course_path)
    #  expect(page).to have_text("Name can't be blank")
    #  expect(page).to have_text("Description can't be blank")
    #end
  end

  context 'Show' do
    it 'Can view a course' do
      course = Fabricate(:course)

      visit course_path(course)
  
      expect(page).to have_text('Curso de Ruby')
      expect(page).to have_text('Curso Avançado de Ruby')
    end
  end

  context 'Index' do
    it 'Can list all courses' do
      rails_course = Fabricate(:course, name: 'Curso de RubyOnRails',
                               description: 'Curso de RubyOnRails para Iniciantes')
      ruby_course = Fabricate(:course, name: 'Curso de Ruby', description: 'Curso Avançado de Ruby')
      
      visit courses_path
      
      expect(page).to have_text('Curso de RubyOnRails')
      expect(page).to have_text('Curso de RubyOnRails para Iniciantes')
      expect(page).to have_text('Curso de Ruby')
      expect(page).to have_text('Curso Avançado de Ruby')
    end
  end
end
