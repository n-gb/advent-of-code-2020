require_relative 'advent_data'

data = AdventData.new(day: 1, session: ARGV[0]).get

entries = data.map(&:to_i)

# iterations variant:
#
# entries.each_with_object([]) do |first_entry, result|
#   entries.shift
#
#   entries.each do |second_entry|
#     if first_entry + second_entry == 2020
#       result << first_entry
#       result << second_entry
#       return puts result.inject(:*)
#     end
#   end
# end

# stylish one-liner:
entries.combination(2) { |pair| return puts(pair.inject(:*)) if pair[0] + pair[1] == 2020 }
