require_relative 'advent_data'

data = AdventData.new(day: 10, session: ARGV[0]).get
adapters = data.map(&:to_i).sort

charging_outlet = 0
device = adapters.max + 3

adapters.unshift(charging_outlet)
adapters << device

one_jolt_diff_clusters = [[]]

adapters.each_with_index do |adapter, index|
  next if index == 0

  case adapter - adapters[index - 1]
  when 1
    one_jolt_diff_clusters.last << adapter
  when 3
    one_jolt_diff_clusters.last.pop
    one_jolt_diff_clusters << []
  end
end

arrangements = 1

one_jolt_diff_clusters.each do |cluster|
  arrangements *= (1..cluster.length).reduce(0, :+) + 1
end

puts arrangements
