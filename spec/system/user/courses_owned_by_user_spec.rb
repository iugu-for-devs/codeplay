require 'rails_helper'

describe 'Ownership of courses' do
  it 'user can see only courses owned' do
    courses = Fabricate.times(3, :course)
    client = Fabricate(:user)
    login_as client, scope: :user
    Fabricate(:order, user: client, course: courses.first)

    visit root_path

    find('#dropdownMenuButton1').click

    within '.dropdown-menu' do
      click_on 'Painel de Controle'
    end

    click_on 'Meus Cursos'

    expect(page).to have_text(courses[0].name)
    expect(page).not_to have_text(courses[1].name)
    expect(page).not_to have_text(courses[2].name)
  end

  it 'buy button not visible to owned courses' do
    courses = Fabricate.times(3, :course)
    client = Fabricate(:user)
    login_as client, scope: :user
    Fabricate(:order, user: client, course: courses.first)

    visit root_path
    within('div#navbarSupportedContent') do
      click_on 'Cursos'
    end

    courses.each do |course|
      expect(page).to have_text(course.name)
    end

    click_on courses[0].name
    expect(page).to have_text(courses[0].name)

    expect(page).not_to have_text('Comprar')
  end

  it 'buy button visible to unowned courses' do
    courses = Fabricate.times(3, :course)
    client = Fabricate(:user)
    login_as client, scope: :user
    Fabricate(:order, user: client, course: courses.first)

    visit root_path
    within('div#navbarSupportedContent') do
      click_on 'Cursos'
    end

    courses.each do |course|
      expect(page).to have_text(course.name)
    end

    click_on courses[1].name
    expect(page).to have_text(courses[1].name)

    expect(page).to have_text('Comprar')
  end

  it 'user can see only courses owned' do
    courses = Fabricate.times(3, :course)
    client = Fabricate(:user)
    login_as client, scope: :user
    Fabricate(:order, user: client, course: courses.first)

    visit root_path

    find('#dropdownMenuButton1').click
    within '.dropdown-menu' do
      click_on 'Painel de Controle'
    end

    click_on 'Meus Cursos'
    click_on courses[0].name
    expect(current_path).to eq(course_path(courses[0]))
  end
end
