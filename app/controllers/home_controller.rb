class HomeController < ApplicationController

  def index
    params = URI.encode_www_form({
                                     part: "snippet",
                                     maxResults: "48",
                                     key: 'AIzaSyBBkzXa908B7gbXBcTLmYyrioGuyHDyEa0',
                                     q: "映画　予告",
                                     type: "video",
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
                                     key: 'AIzaSyBBkzXa908B7gbXBcTLmYyrioGuyHDyEa0',
                                     id: @videoId,
                                 })

    uri = URI.parse("https://www.googleapis.com/youtube/v3/videos?#{params}")

    response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.get(uri.request_uri)
    end

    @video = JSON.parse(response.body)
  end

end

