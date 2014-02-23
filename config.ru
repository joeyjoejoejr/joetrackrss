require "rubygems"
require "sinatra"
require "dotenv"

Dotenv.load

require File.expand_path '../joe_tracker_feed.rb', __FILE__

run JoeTrackerFeed
