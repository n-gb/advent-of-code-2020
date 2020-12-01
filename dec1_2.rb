require_relative 'advent_data'

data = AdventData.new(day: 1, session: ARGV[0]).get

entries = data.map(&:to_i)

# iterations variant:
#
# entries.each_with_object([]) do |first_entry, result|
#   entries.shift
#
#   entries.each do |second_entry|
#     entries.each do |third_entry|
#       if first_entry + second_entry + third_entry == 2020
#         result << first_entry
#         result << second_entry
#         result << third_entry
#         return puts result.inject(:*)
#       end
#     end
#   end
# end

# stylish one-liner:
entries.combination(3) { |triad| return puts(triad.inject(:*)) if triad[0] + triad[1] + triad[2] == 2020 }
