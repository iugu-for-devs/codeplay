require 'rails_helper'

describe 'Course Requirements' do
  it 'User view courses requirements' do
    user = Fabricate(:user)
    login_as user, scope: user
    course = Fabricate(:course)
    required_course = Fabricate(:course)
    course.requirements << required_course

    visit courses_path
    click_on course.name

    expect(page).to have_text('Requisito(s):')
    expect(page).to have_text(required_course.name)
  end

  it '' do
    
  end
end
