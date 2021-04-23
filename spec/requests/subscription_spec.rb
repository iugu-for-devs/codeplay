require 'rails_helper'

describe 'Subscription plan', type: :request do
  it 'non admin cannot get to new form subscription plan' do
    user = Fabricate(:user)
    login_as user, scope: :user

    get new_subscription_path

    expect(response).to redirect_to(new_admin_session_path)
  end

  it 'non admin cannot create subscription plan' do
    user = Fabricate(:user)
    login_as user, scope: :user

    post subscriptions_path, params: {
      subscription: Fabricate(:subscription)
    }

    expect(response).to redirect_to(new_admin_session_path)
  end

  xit 'non admin cannot add a course to subscription' do
    user = Fabricate(:user)
    login_as user, scope: :user
    course = Fabricate(:course)
    subscription = Fabricate(:subscription)

    post add_subscription_course_path(subscription, course), params: {
      course_id: course.id
    }

    expect(response).to redirect_to(new_admin_session_path)
  end
end
