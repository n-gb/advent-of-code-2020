require_relative 'advent_data'

DATA = AdventData.new(day: 3, session: ARGV[0]).get

def path_trees(right, down)
  line_length = DATA.first.length
  height = DATA.length
  position = 0
  trees = 0

  (down...height).step(down) do |line_num|
    position = (position + right) % line_length
    trees += 1 if DATA[line_num][position] == '#'
  end

  trees
end

puts path_trees(1, 1) * path_trees(3, 1) * path_trees(5, 1) * path_trees(7, 1) * path_trees(1, 2)
