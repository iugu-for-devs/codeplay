require 'rails_helper'

RSpec.describe TextLesson, type: :model do
  it 'attributes name and video_code cannot be blank' do
    text_lesson = TextLesson.new

    expect(text_lesson).to_not be_valid
    expect(text_lesson.errors[:name]).to include('não pode ficar em branco')
    expect(text_lesson.errors[:lesson_body]).to include('não pode ficar em branco')
  end

  it 'belongs to course' do
    text_lesson = TextLesson.new

    expect(text_lesson).to_not be_valid
    expect(text_lesson.errors[:course]).to include('é obrigatório(a)')
  end
end
