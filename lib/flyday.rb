require 'mechanize'

class Flyday
  attr_reader :airline

  def initialize
    @airline = 'southwest'
    @mechanize = Mechanize.new
    @mechanize.agent.user_agent = "Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25"
    # @mechanize.agent.set_proxy 'localhost', 8888
    # @mechanize.agent.http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    # @mechanize.agent.certificate='charles.crt'
    @mechanize.log = Logger.new "flyday.log"
  end

  def search_hash
    {
      "flowName" => "book",
      "omni_reload" => "false",
      "twoWayTrip" => "false",
      "returnAirport" => " ",
      "returnAirport_displayed" => " ",
      "fareType" => "DOLLARS",
      "originAirport" => "CAK",
      "originAirport_displayed" => "Akron-Canton, OH - CAK",
      "destinationAirport" => "ATL",
      "destinationAirport_displayed" => "Atlanta, GA - ATL",
      "outboundDateString" => "01/15/2016",
      "omni_outboundDateString" => "01/15/2016",
      "returnDateString" => " ",
      "omni_returnDateString" => "01/16/2016",
      "outboundTimeOfDay" => "ANYTIME",
      "returnTimeOfDay" => " ",
      "adultPassengerCount" => "1",
      "seniorPassengerCount" => "0",
      "promoCode" => " ",
      "serviceID" => "flightoptions",
      "appID" => "swa",
      "appver" => "2.19.0",
      "channel" => "wap",
      "platform" => "thinclient",
      "cacheid" => " ",
      "rcid" => "spaiphone",
    }
  end

  def search(date)
    # @mechanize.get('https://southwest.com/')
    # post = @mechanize.post('https://southwest.com/flight/search-flight.html',{
    #   'originAirport' => 'MDW',
    #   'twoWayTrip' => 'false',
    #   'promoCode ' => '',
    #   'returnDateString'  => '',
    #   'destinationAirport' => 'XYZ',
    #   'outboundDateString' => '01/14/2016',
    #   'adultPassengerCount' => '1',
    #   'seniorPassengerCount' => '0',
    #   'fareType' => 'DOLLARS',
    # })
    @mechanize.get('https://mobile.southwest.com')
    post = @mechanize.post('https://mobile.southwest.com/middleware/MWServlet',{
      serviceID: 'getTravelInfo',
      appID: 'swa',
      appver: '2.19.0',
      channel: 'wap',
      platform: 'thinclient',
      cacheid:' ',
      rcid: 'spaiphone'
    }, {"Content-Type" => "application/x-www-form-urlencoded"})
    # binding.pry
    File.write("hello.html", post.body)
    post = @mechanize.post('https://mobile.southwest.com/middleware/MWServlet',
    # 'flowName=book&omni_reload=false&twoWayTrip=false&returnAirport=&returnAirport_displayed=&fareType=DOLLARS&originAirport=CAK&originAirport_displayed=Akron-Canton%2C%20OH%20-%20CAK&destinationAirport=ATL&destinationAirport_displayed=Atlanta%2C%20GA%20-%20ATL&outboundDateString=01%2F15%2F2016&omni_outboundDateString=01%2F15%2F2016&returnDateString=&omni_returnDateString=01%2F16%2F2016&outboundTimeOfDay=ANYTIME&returnTimeOfDay=&adultPassengerCount=1&seniorPassengerCount=0&promoCode=&serviceID=flightoptions&appID=swa&appver=2.19.0&channel=wap&platform=thinclient&cacheid=&rcid=spaiphone',
    search_hash,
    {"Content-Type" => "application/x-www-form-urlencoded"})
    # File.write("hello.html", post.body)
    []
  end
end
