require 'mechanize'
require 'json'
require_relative 'flight'

# The Flyday class contains the #search method for finding southwest flights
# between two airports on a date. You can only search for one way tickets.
class Flyday
  attr_reader :airline

  def initialize
    @airline = 'southwest'
    @mechanize = Mechanize.new
    @mechanize.log = Logger.new 'flyday.log'
    @mechanize.agent.http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  end

  def params(orig, dest, date)
    {
      'currency-type' => 'Dollars',
      'number-adult-passengers' => '1',
      'number-senior-passengers' => '0',
      'promo-code' => '',
      'origination-airport' => orig,
      'destination-airport' => dest,
      'departure-date' => date.strftime('%Y-%m-%d')
    }
  end

  def headers
    {
      'X-API-Key' => 'l7xx8d8bfce4ee874269bedc02832674129b',
      'Content-Type' => 'application/vnd.swacorp.com.accounts.login-v1.0+json',
      'User-Agent' => 'Southwest/3.1.100 (iPad; iOS 8.3; Scale/2.00)'
    }
  end

  def search(orig:'MDW', dest:'ATL', date:Date.today)
    url = 'https://api-extensions.southwest.com/v1/mobile/flights/products'
    resp = @mechanize.get(url, params(orig, dest, date), nil, headers)
    fail 'Request Failed' if resp.code != '200'
    JSON.parse(resp.body)['trips'][0]['airProducts'].map { |l| Flight.new(l) }
  end
end
