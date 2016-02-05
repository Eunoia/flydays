class Flyday
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

    # def segments
    #   # @segments.map{ |s| Flight.new(s) }
    # end

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

    def inspect
      "<#Flyday::Flight #{segments_path} #{departure_date}T#{departure_time} seats:#{seats_left}, price_range:#{price_range}>"
    end
  end
end
