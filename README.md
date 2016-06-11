# Flydays

Lightweight gem to search southwest for one way flights between airports.

## Installation

Add this line to your application's Gemfile:

    gem 'flydays'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install flydays
    

## Usage

		flyday = Flyday.new
		flights = flyday.search(date: Date.today, orig: "MDW", "ATL")
		flights[0]
			=> "<#Flyday::Flight MDW->ATL 2016-07-01T05:25 seats:24, price_range:220-342>"
		flights[1]
			=> "<#Flyday::Flight MDW->MCI->ATL 2016-07-01T05:50 seats:17, price_range:228-350>"
		pp flights[1].flatten
			[
			  [0] <#Flyday::Flight MDW->MCI 2016-07-01T05:50 seats:24, price_range:179-272>,
			  [1] <#Flyday::Flight MCI->ATL 2016-07-01T09:00 seats:17, price_range:186-345>
			]

# Testing

Rspec is used for testing, run tests with `rspec`. While developing use `guard` to run tests when files change.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
