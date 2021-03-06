require 'rails_helper'

describe 'Course management', type: :request do
  context 'Create' do
    let(:admin) { Fabricate(:admin) }
    let(:course) { Fabricate.build(:course) }

    it 'When data is valid' do
      login_as(admin, scope: :admin)
      post admin_courses_path, params: { course: course.attributes }

      expect(response).to redirect_to(admin_course_path(Course.last))
      follow_redirect!

      assert_select 'h2', course.name
      assert_select 'h2', course.description
    end

    it 'When data is not valid' do
      login_as(admin, scope: :admin)
      post admin_courses_path, params: { course: { name: '', description: '' } }

      expect(response.body).to match('Nome não pode ficar em branco')
      expect(response.body).to match('Descrição não pode ficar em branco')
      expect(Course.count).to eq(0)
    end

    it 'Create without login as admin' do
      post admin_courses_path, params: { course: course.attributes }

      expect(response).to redirect_to(new_admin_session_path)
      expect(Course.count).to eq(0)
    end
  end
end
