require 'rails_helper'

describe 'View Subscriptions' do
  it 'user can see subscriptions plans' do
    subscription = Fabricate(:subscription)
    other_subscription = Fabricate(:subscription,
                                   name: 'Jornada Mobile com Dart e Flutter',
                                   description: 'Esta assinatura irá englobar todos os cursos'\
                                                'de Dart e o framework Flutter')

    visit root_path
    click_on 'Planos de Assinatura'

    expect(page).to have_text(subscription.name)
    expect(page).to have_text(subscription.description)
    expect(page).to have_text(other_subscription.name)
    expect(page).to have_text(other_subscription.description)
  end

  # it 'user see subscription plan details' do
  #   course = Fabricate(:course)
  #   Fabricate.times(3, :lesson, course: course)
  #   subscription = Fabricate(:subscription)
  #   subscription.courses << course

  #   visit root_path
  #   click_on 'Planos de Assinatura'
  #   click_on subscription.name
  #   click_on course.name

  #   expect(page).to have_text(course.name)
  #   expect(page).to have_text(course.description)
  #   course.lessons.each do |lesson|
  #     expect(page).to have_text(lesson.name)
  #     expect(page).to have_text(lesson.description)
  #   end
  # end
end
