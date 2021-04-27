require 'rails_helper'

describe 'Course Requirements' do
  it 'Admin can add requirements to course' do
    admin = Fabricate(:admin)
    courses = Fabricate.times(2, :course)
    login_as admin, scope: :admin

    visit admin_course_path(courses.first)
    click_on 'Listar Requerimentos'
    fill_in 'Nome do curso', with: courses.last.name
    click_on 'Buscar'
    select courses.last.name
    click_on 'Adicionar curso'

    expect(page).to have_text(courses.last.name)
  end

  it 'Admin can remove requirements from course' do
    admin = Fabricate(:admin)
    courses = Fabricate.times(2, :course)
    courses.first.requirements << courses.last
    login_as admin, scope: :admin

    visit admin_course_path(courses.first)
    click_on 'Listar Requerimentos'

    
    within "div#Curso#{courses.last.id}" do
        click_on 'Remover'
    end
    expect(page).to_not have_text(courses.last.name)
  end


end