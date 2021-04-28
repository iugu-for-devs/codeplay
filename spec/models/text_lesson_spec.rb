require 'rails_helper'

RSpec.describe TextLesson, type: :model do
  it { should validate_presence_of(:name).with_message('não pode ficar em branco') }

  it { should validate_presence_of(:lesson_body).with_message('não pode ficar em branco') }

  it { should belong_to(:course) }
end
