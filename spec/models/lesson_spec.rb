require 'rails_helper'

RSpec.describe Lesson, type: :model do
  it 'attributes name and video_code cannot be blank' do
    lesson = Lesson.new

    expect(lesson).to_not be_valid
    expect(lesson.errors[:name]).to include('não pode ficar em branco')
    expect(lesson.errors[:video_code]).to include('não pode ficar em branco')
  end

  it 'belongs to course' do
    lesson = Lesson.new

    expect(lesson).to_not be_valid
    expect(lesson.errors[:course]).to include('é obrigatório(a)')
  end

  it 'video_code must be unique' do
    Fabricate(:lesson, video_code: '1234')
    lesson = Lesson.new(video_code: '1234')

    expect(lesson).to_not be_valid
    expect(lesson.errors[:video_code]).to include('já está em uso')
  end
end
