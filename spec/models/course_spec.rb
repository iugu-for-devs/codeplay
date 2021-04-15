require 'rails_helper'

RSpec.describe Course, type: :model do
  describe 'validates' do
    context 'attributes cannot be blank' do
      it { is_expected.to  validate_presence_of(:name) }
      it { is_expected.to  validate_presence_of(:description) }
    end
  end
end
