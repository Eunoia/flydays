require 'spec_helper'

describe Flyday do
  before do
    Timecop.freeze(Time.local(2016, 7, 1, 12))
    @flight = nil
    @flight_with_layover = nil
    VCR.use_cassette('flyday') do
      flyday = Flyday.new
      @flight, @flight_with_layover, *_ = flyday.search
      @flight_with_layover.flatten
    end
  end

  describe '.inspect' do
    it 'contains data about a flight' do
      ts = '2016-07-01T05:25'
      s = "<#Flyday::Flight MDW->ATL #{ts} seats:24, price_range:220-342>"
      expect(@flight.inspect).to eq(s)
    end
  end

  describe '.impacted?' do
    it 'returns true if only one seat available' do
      expect(@flight.impacted?).to eq(false)
    end
  end
  describe '.land_at' do
    it 'returns when the plane lands at' do
      expect(@flight.land_at).to eq('2016-07-01T08:10')
    end
    
  end
  describe '.flatten' do
    it 'returns a direct flight in an array' do
      expect(@flight.flatten).to eq([@flight])
    end
    it 'returns two flights when the flight has a layover' do
      VCR.use_cassette('flyday') do
        expect(@flight_with_layover.flatten.length).to eq(2)
      end
    end
  end

  after do
    VCR.eject_cassette
  end
end
