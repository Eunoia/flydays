require 'mechanize'

class Flyday
  attr_reader :airline

  def initialize
    @airline = 'southwest'
    @mechanize = Mechanize.new
    @mechanize.agent.user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.111 Safari/537.36"
    @mechanize.agent.set_proxy 'localhost', 8888
    @mechanize.agent.http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    @mechanize.agent.certificate='charles.crt'
    @mechanize.log = Logger.new "flyday.log"
  end


  def search(date)
    @mechanize.get('https://southwest.com/')
    post = @mechanize.post('https://southwest.com/flight/search-flight.html',{
      'originAirport' => 'MDW',
      'twoWayTrip' => 'false',
      'promoCode ' => '',
      'returnDateString'  => '',
      'destinationAirport' => 'XYZ',
      'outboundDateString' => '01/14/2016',
      'adultPassengerCount' => '1',
      'seniorPassengerCount' => '0',
      'fareType' => 'DOLLARS',
    })
    File.write("hello.html", post.body)
    []
  end
end
