require 'mechanize'
require 'json'

class Flyday
  attr_reader :airline

  def initialize(use_proxy=false)
    @airline = 'southwest'
    @mechanize = Mechanize.new
    @mechanize.agent.user_agent = "Look, a custom user agent"
    if use_proxy
      @mechanize.agent.set_proxy 'localhost', 8888
      @mechanize.agent.http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      @mechanize.agent.certificate='charles.crt'
    end
    @mechanize.log = Logger.new "flyday.log"
  end

  def search(date=Date.today, seats: 1)
    post = @mechanize.post('https://mobile.southwest.com/middleware/MWServlet',
    "flowName=book&omni_reload=false&twoWayTrip=false&returnAirport=&returnAirport_displayed=&fareType=DOLLARS&originAirport=MDW&originAirport_displayed=Chicago%20(Midway)%2C%20IL%20-%20MDW&destinationAirport=ATL&destinationAirport_displayed=Atlanta%2C%20GA%20-%20ATL&outboundDateString=#{date.strftime("%m%%2F%d%%2F%Y")}&omni_outboundDateString=01%2F19%2F2016&returnDateString=&omni_returnDateString=01%2F20%2F2016&outboundTimeOfDay=ANYTIME&returnTimeOfDay=&adultPassengerCount=#{seats}&seniorPassengerCount=0&promoCode=&serviceID=flightoptions&appID=swa&appver=2.19.0&channel=wap&platform=thinclient&cacheid=&rcid=spaiphone&",
    { 'Cookie' => "cacheid=#{ENV["CACHEID"]};" })
    json = JSON.parse(post.body)
    json['out_flight_options']
  end
end
