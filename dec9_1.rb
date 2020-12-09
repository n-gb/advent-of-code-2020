require_relative 'advent_data'

data = AdventData.new(day: 9, session: ARGV[0]).get
data = data.map(&:to_i)

data[25..-1].each_with_index do |number, index|
  found = false

  data[index...(index + 25)].combination(2) do |pair|
    if pair[0] + pair[1] == number
      found = true
      break
    end
  end

  return puts(number) unless found
end
