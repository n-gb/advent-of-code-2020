require_relative 'advent_data'

data = AdventData.new(day: 13, session: ARGV[0]).get

timestamp = data.first.to_i
buses = data.last.split(',').reject { |bus_id| bus_id == 'x' }.map(&:to_i)

earliest_departures = {}

buses.each do |bus_id|
  earliest_bus_departure = 0

  (0..).step(bus_id) do |x|
    if x > timestamp
      earliest_bus_departure = x
      break
    end
  end

  earliest_departures[bus_id] = earliest_bus_departure
end

earliest_departure = earliest_departures.values.min
earliest_bus_id = earliest_departures.key(earliest_departure)

earliest_departure_in = earliest_departure % timestamp

puts earliest_bus_id * earliest_departure_in
