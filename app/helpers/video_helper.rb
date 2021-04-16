module VideoHelper
  VIMEO_PLAYER_URL = 'https://player.vimeo.com/video/'.freeze

  def vimeo_iframe(video_code)
    tag.iframe(nil, src: "#{VIMEO_PLAYER_URL}#{video_code}", width: '640',
                    height: '360', frameborder: '0', allow: 'fullscreen',
                    allowfullscreen: true)
  end
end

# vimeo embed template
# <iframe
# src="https://player.vimeo.com/video/"
# width="640"
# height="360"
# frameborder="0"
# allow="fullscreen; picture-in-picture"
# allowfullscreen>
# </iframe>
