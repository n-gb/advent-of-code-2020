require_relative 'advent_data'

data = AdventData.new(day: 13, session: ARGV[0]).get

buses = data.last.split(',')
bus_ids = buses.reject { |bus_id| bus_id == 'x' }.map(&:to_i)

remainders = bus_ids.map { |bus_id| bus_id - buses.index(bus_id.to_s) }

def extended_gcd(a, b)
  last_remainder, remainder = a.abs, b.abs
  x, last_x, y, last_y = 0, 1, 1, 0
  while remainder != 0
    last_remainder, (quotient, remainder) = remainder, last_remainder.divmod(remainder)
    x, last_x = last_x - quotient*x, x
    y, last_y = last_y - quotient*y, y
  end
  return last_remainder, last_x * (a < 0 ? -1 : 1)
end

def invmod(e, id)
  g, x = extended_gcd(e, id)
  x % id
end

def chinese_remainder(ids, remainders)
  product = ids.inject(:*)
  series = remainders.zip(ids).map{ |remainder, id| (remainder * product * invmod(product/id, id) / id) }
  series.inject(:+) % product
end

puts chinese_remainder(bus_ids, remainders)
