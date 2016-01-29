require 'mechanize'
require 'json'
require_relative 'flight'

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

  def search(orig:'MDW', dest:'ATL', date:Date.today)
    url = 'https://api-extensions.southwest.com/v1/mobile/flights/products'
    params = {
      'currency-type' => 'Dollars',
      'number-adult-passengers' => '1',
      'number-senior-passengers' => '0',
      'promo-code' => '',
      'origination-airport' => orig,
      'destination-airport' => dest,
      'departure-date' => date.strftime('%Y-%m-%d')
    }
    headers = {
      'X-API-Key' => 'l7xx8d8bfce4ee874269bedc02832674129b',
      'User-Agent' => 'Southwest/3.1.100 (iPad; iOS 8.3; Scale/2.00)'
    }
    resp = @mechanize.get(url, params, nil, headers) rescue binding.pry
    if resp.code == '200'
      JSON.parse(resp.body)['trips'][0]['airProducts'].map{ |l| Flight.new(l) }
    end
  end
end
