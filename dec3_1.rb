require_relative 'advent_data'

data = AdventData.new(day: 3, session: ARGV[0]).get

line_length = data.first.length
height = data.length
position = 0
trees = 0

for line_num in 1...height
  position = (position + 3) % line_length
  trees += 1 if data[line_num][position] == '#'
end

puts trees
