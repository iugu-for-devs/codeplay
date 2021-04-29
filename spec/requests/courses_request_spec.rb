require 'rails_helper'

describe 'Course management', type: :request do
  context 'Create' do
    let(:admin) { Fabricate(:admin) }

    it 'When data is valid' do
      login_admin(admin)
      course_params = Fabricate.attributes_for(:course)

      expect do
        post admin_courses_path, params: { course: course_params }
      end.to change(Course, :count).by(1)
      follow_redirect!

      expect(response.body).to include(course_params['name'], course_params['description'])
    end

    it 'When data is not valid' do
      login_admin(admin)
      expect do
        post admin_courses_path, params: { course: { name: '', description: '' } }
      end.to change(Course, :count).by(0)

      expect(response.body).to match('Nome não pode ficar em branco')
      expect(response.body).to match('Descrição não pode ficar em branco')
    end

    it 'Create without login as admin' do
      course_params = Fabricate.attributes_for(:course)
      expect do
        post admin_courses_path, params: { course: course_params }
      end.to change(Course, :count).by(0)

      expect(response).to redirect_to(new_admin_session_path)
    end
  end
end
