require 'spec_helper'

describe Flyday do
  before do
    Timecop.freeze(Time.local(2016, 2, 1, 12))
    @flight = nil
    VCR.use_cassette('flyday') do
      flyday = Flyday.new
      @flight = flyday.search[0]
    end
  end

  describe '.inspect' do
    it 'contains data about a flight' do
      ts = "2016-02-01T05:30"
      s = "<#Flyday::Flight MDW->ATL #{ts} seats:24, price_range:222-329>"
      expect(@flight.inspect).to eq(s)
    end
  end

  describe '.impacted?' do
    it 'returns true if only one seat available' do
      expect(@flight.impacted?).to eq(false)
    end
  end

  after do
    VCR.eject_cassette
  end
end
