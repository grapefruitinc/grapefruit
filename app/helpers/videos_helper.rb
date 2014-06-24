module VideosHelper
  def youtube_id_to_url(ytid)
    unless ytid.nil?
      return 'https://youtube.com/watch?v=' + ytid
    end
  end
end
