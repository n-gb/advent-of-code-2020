require_relative 'advent_data'

data = AdventData.new(day: 6, session: ARGV[0]).get

group_answers = [[]]

data.each { |string| string == '' ? group_answers << [] : group_answers.last.concat(string.chars) }

overlap_sum = 0

group_answers.each { |group_answer| overlap_sum += group_answer.uniq.length }

puts overlap_sum
