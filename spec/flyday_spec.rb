require 'spec_helper'

describe Flyday do
	describe '.new' do
		it "has an airline" do
			flyday = Flyday.new
			expect(flyday.airline).to eq('southwest')
		end
	end
end