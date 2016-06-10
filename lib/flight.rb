class Flyday
  # Flight contains the details of the flights between two cities.
  class Flight
    attr_reader :orig, :dest, :departure_date, :departure_time, :segments
    def initialize(blob)
      @blob = blob
      @segments = blob['segments']
      @orig = blob['segments'][0]['originationAirportCode']
      @dest = blob['segments'][-1]['destinationAirportCode']
      departure_date_time = blob['segments'][0]['departureDateTime']
      @departure_date, @departure_time = departure_date_time.split('T')
    end

    def flight_number
      @segments.map { |s| s['operatingCarrierInfo'].values.join }.join(' ')
    end

    def seats_left
      @blob['fareProducts'].map { |p| p['seatsAvailable'].to_i }.inject(:+)
    end

    def segments_path
      final = @segments[-1]['destinationAirportCode']
      @segments.map { |l| l['originationAirportCode'] }.push(final).join('->')
    end

    def impacted?
      seats_left == 1
    end

    def price_range
      products = @blob['fareProducts']
      max, min = products.minmax { |l| l['currencyPrice']['totalFareCents'] }
      min = min['currencyPrice']['totalFareCents'] / 100
      max = max['currencyPrice']['totalFareCents'] / 100

      "#{min}-#{max}"
    end

    def flatten
      return [self] if @segments.length == 1
      @segments.map do |segment|
        Flyday.new.search(
          date: Date.parse(departure_date),
          orig: segment['originationAirportCode'],
          dest: segment['destinationAirportCode']
        ).detect do |f|
          f.flight_number == segment['marketingCarrierInfo'].values.join('')
        end
      end
    end

    def takeoff_at
      "#{departure_date}T#{departure_time}"
    end

    def land_at
      @blob['segments'][-1]['arrivalDateTime']
    end

    def inspect
      object = '<#Flyday::Flight'
      takeoff = "#{departure_date}T#{departure_time}"
      fare_info = "seats:#{seats_left}, price_range:#{price_range}"
      "#{object} #{segments_path} #{takeoff} #{fare_info}>"
    end
  end
end
