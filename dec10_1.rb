require_relative 'advent_data'

data = AdventData.new(day: 10, session: ARGV[0]).get
adapters = data.map(&:to_i).sort

charging_outlet = 0
device = adapters.max + 3

adapters.unshift(charging_outlet)
adapters << device

one_jolt_diff = 0
two_jolt_diff = 0
three_jolt_diff = 0

adapters.each_with_index do |adapter, index|
  next if index == 0

  case adapter - adapters[index - 1]
  when 1
    one_jolt_diff += 1
  when 2
    two_jolt_diff += 1
  when 3
    three_jolt_diff += 1
  end
end

puts one_jolt_diff * three_jolt_diff
