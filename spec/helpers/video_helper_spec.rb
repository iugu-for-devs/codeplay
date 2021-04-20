require 'rails_helper'

describe VideoHelper do
  it '#vimeo_iframe' do
    lesson = Fabricate(:lesson, video_code: 'ABC123')
    content_tag = helper.vimeo_iframe(lesson.video_code)
    expect(content_tag).to eq('<iframe src="https://player.vimeo.com/video/ABC123" width="640" '\
                              'height="360" frameborder="0" allow="fullscreen" '\
                              'allowfullscreen="allowfullscreen"></iframe>')
  end
end
