require_relative 'flyday.rb'

module SeatsOnFlight
	def lookup(date, orig, dest, flight_number)
		results = Flyday.search(orig: orig, dest: dest, date: date)
		flight = results.select{ |r| r.flight_number=~/#{flight_number}/ }
		flight.seats_left
	end
end
