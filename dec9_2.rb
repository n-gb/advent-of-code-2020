require_relative 'advent_data'


data = AdventData.new(day: 9, session: ARGV[0]).get
data = data.map(&:to_i)

invalid_number = 0

data[25..-1].each_with_index do |number, index|
  found = false

  data[index, 25].combination(2) do |pair|
    if pair[0] + pair[1] == number
      found = true
      break
    end
  end

  unless found
    invalid_number = number
    break
  end
end

smaller_data = data.reject { |number| number >= invalid_number }

(0...smaller_data.length).each do |index|
  numbers_array = []

  smaller_data[index..-1].each do |number|
    numbers_array << number
    break if numbers_array.sum >= invalid_number
  end

  return puts(numbers_array.min + numbers_array.max) if numbers_array.sum == invalid_number
end
