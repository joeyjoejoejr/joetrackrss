require 'date'
require 'time'
require 'json'
require 'net/http'


class Track
  def self.for_feed(params = {})
    days = params.fetch(:days) { 7 }
    max = params.fetch(:max) { 25 }
    days_ago = DateTime.now - days.to_i
    time_ago = Time.parse(days_ago.to_s).utc.iso8601(3)
    new.find(created_at_gt: time_ago, limit: max)
  end

  def find(query)
    uri = URI('https://api.parse.com/1/classes/Joetrack')
    params = {
      where: created_at_gt_query(query.fetch(:created_at_gt)),
      limit: query.fetch(:limit),
      order: "-createdAt"
    }
    uri.query = URI.encode_www_form(params)
    request = Net::HTTP::Get.new(uri)
    request["X-Parse-Application-Id"] = ENV["PARSE_APP_KEY"]
    request["X-Parse-REST-API-Key"] = ENV["PARSE_REST_KEY"]

    http = Net::HTTP.new(uri.hostname, uri.port)
    http.use_ssl = true
    response = http.request(request)
    JSON.parse(response.body)['results']
  end

  def created_at_gt_query(iso_datetime)
    {
      createdAt: {
        "$gt" => {
          "__type" => "Date",
          iso: iso_datetime
        }
      }
    }.to_json
  end
end
