require 'net/http'
require 'uri'

class AdventData
  def initialize(day:, session:)
    @day = day
    @session = session
  end

  def get
    uri = URI.parse("https://adventofcode.com/2020/day/#{day}/input")
    request = Net::HTTP::Get.new(uri)
    request['Cookie'] = "session=#{session}"

    response = Net::HTTP.start(uri.hostname, uri.port, { use_ssl: true }) do |http|
      http.request(request)
    end

    response.body.split("\n")
  end

  private

  attr_reader :day, :session
end
