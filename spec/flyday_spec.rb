require 'spec_helper'

describe Flyday do
	describe '.new' do
		it "has an airline" do
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
end
