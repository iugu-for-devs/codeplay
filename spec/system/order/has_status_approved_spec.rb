require 'rails_helper'

describe 'has status approved' do
  it 'user can access course lessons' do
    client = login_user
    course = Fabricate(:course)
    course_lessons = Fabricate.times(5, :lesson, course: course)
    order = Fabricate(:order, user: client, course: course)

    allow(order).to receive(:send_invoice_request).and_return({ status: 'approved',
                                                                token: returned_token })

    visit course_path(course)

    expect(page).to have_no_content('Comprar')

    click_on('Aulas')

    expect(course_lessons.count).to eq(5)
    course_lessons.each do |lesson|
      expect(page).to have_content(lesson.name)
    end
  end

  # it 'user can see the course in your course list' do
  # 	client = login_user
  # course = Fabricate.times(5,:course)

  # order  = Fabricate(:order, user: client, course: course)

  #  visit user_dashbord_path(user)

  #  click_on('Meus Cursos')

  # 	expect(page).to have_content()
  # end

  # it 'user can see the course receipt' do
  #  	client = login_user
  # course = Fabricate(:course)
  # order  = Fabricate(:order, user: client, course: course)

  #  allow(order).to receive(:send_invoice_request).and_return({ status: "approved",
  # 																											  		token: returned_token
  # 																										  		})

  #  visit user_receipts_path
  #  click_on course.name

  #  expect(page).to have_content(course.name)
  #  expect(page).to have_content("Data da compra do curso")
  #  expect(page).to have_content("Compra Aprovada")
  #  expect(page).to have_link("Link para o courso : #{course.name}", course_path(course))
  # end
end
