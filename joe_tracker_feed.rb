require 'sinatra'
require_relative 'lib/track'

class JoeTrackerFeed < Sinatra::Base
  # creates an rss feed with a default of one weeks worth of track.
  # It takes params "?days=<integer>&max=<integer>"
  get '/rss' do
    @tracks = Track.for_feed(params)
    builder :rss
  end
end
