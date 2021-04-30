require 'rails_helper'

describe 'has status approved' do
  it 'user can access course lessons' do
    login_user
    course = Fabricate(:course)
    course_lessons = Fabricate.times(5, :lesson, course: course)

    # Fabricate(:order,
    #           user: client,
    #           course: course,
    #           status: 'approved')

    visit course_path(course)
    click_on 'Comprar'
    select 'Boleto', from: 'Forma de Pagamento'
    click_on 'Efetuar Compra'

    expect(page).to have_no_content('Comprar')
    expect(course_lessons.count).to eq(5)
    course_lessons.each do |lesson|
      expect(page).to have_content(lesson.name)
    end
  end

  it 'user can access course text lessons' do
    login_user
    course = Fabricate(:course)
    course_lessons = Fabricate.times(5, :text_lesson, course: course)

    # Fabricate(:order,
    #           user: client,
    #           course: course,
    #           status: 'approved')

    visit course_path(course)
    click_on 'Comprar'
    select 'Boleto', from: 'Forma de Pagamento'
    click_on 'Efetuar Compra'

    expect(page).to have_no_content('Comprar')
    expect(course_lessons.count).to eq(5)
    course_lessons.each do |lesson|
      expect(page).to have_content(lesson.name)
    end
  end

  it 'user can see the course in your course list' do
    client = login_user

    orders = Fabricate.times(4, :order,
                             user: client,
                             status: 'approved')

    user_courses = orders.map(&:course)

    visit user_courses_path(client)

    user_courses.each do |course|
      expect(page).to have_content(course.name)
      expect(page).to have_content(course.description)
    end
  end

  # it 'user can see the course receipt' do
  #   client = login_user
  #   course = Fabricate(:course)
  #   order  = Fabricate(:order, user: client, course: course)

  #   visit user_receipts_path
  #   click_on course.name

  #   expect(page).to have_content(course.name)
  #   expect(page).to have_content("Data da compra do curso")
  #   expect(page).to have_content("Compra Aprovada")
  #   expect(page).to have_link("Link para o courso : #{course.name}", course_path(course))
  # end
end
