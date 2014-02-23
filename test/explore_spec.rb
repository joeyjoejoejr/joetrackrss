require 'dotenv'
Dotenv.load
require_relative '../lib/track'

describe Track do
  it "find some for feed" do
    pp Track.for_feed
  end
end
