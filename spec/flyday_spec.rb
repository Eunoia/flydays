require 'spec_helper'

describe Flyday do
  before do
    Timecop.freeze(Time.local(2016, 7, 1, 12))
    VCR.insert_cassette 'flyday'
  end
  describe '.new' do
    it 'has an airline' do
      flyday = Flyday.new
      expect(flyday.airline).to eq('southwest')
    end
  end

  describe '.search' do
    it 'returns a page of flights' do
      flyday = Flyday.new
      flights = flyday.search(date: Date.today)
      expect(flights).to be_a(Array)
    end
  end
  after do
    VCR.eject_cassette
  end
end
