class HomeController < ApplicationController

  def index
    params = URI.encode_www_form({
                                     part: "snippet",
                                     maxResults: "48",
                                     key: 'AIzaSyC-jNeYBgKMXg9EooWystwXZtRKJPJsgFM',
                                     q: '映画　予告　公式',
                                     type: 'video',
                                     order: "date",
                                     videoCategoryId: '1'
                                 })

    uri = URI.parse("https://www.googleapis.com/youtube/v3/search?#{params}")

    response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.get(uri.request_uri)
    end

    @result = JSON.parse(response.body)
  end

  def show
    @videoId = params[:id]
    params = URI.encode_www_form({
                                     part: "snippet",
                                     key: 'AIzaSyC-jNeYBgKMXg9EooWystwXZtRKJPJsgFM',
                                     id: @videoId,
                                 })

    uri = URI.parse("https://www.googleapis.com/youtube/v3/videos?#{params}")

    response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.get(uri.request_uri)
    end

    @video = JSON.parse(response.body)
  end

end

