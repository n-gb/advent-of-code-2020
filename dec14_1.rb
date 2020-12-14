require_relative 'advent_data'

data = AdventData.new(day: 14, session: ARGV[0]).get

def masked(number, mask)
  and_mask = mask.gsub('X', '1').to_i(2)
  or_mask = mask.gsub('X', '0').to_i(2)

  ((number & and_mask) | or_mask)
end

mask = ''
mem = []

data.each do |instruction|
  what, value = instruction.split(' = ')

  if what == 'mask'
    mask = value
  else
    index = what.scan(/\d+/).first.to_i
    mem[index] = masked(value.to_i, mask)
  end
end

puts mem.compact.sum
