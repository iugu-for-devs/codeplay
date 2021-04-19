require 'rails_helper'

describe 'Course management', type: :request do
  context 'Create' do
    let(:admin) { Fabricate(:admin) }
    let(:course) { Fabricate.build(:course) }

    it 'When data is valid' do
      login_as(admin, scope: :admin)
      post '/courses', params: { course: course.attributes }

      assert_redirected_to course_path(Course.last)
      follow_redirect!

      assert_select 'h3', course.name
      assert_select 'dd', course.description
    end

    it 'Create without login as admin' do
      post '/courses', params: { course: course.attributes }

      assert_redirected_to new_admin_session_path
    end
  end
end
