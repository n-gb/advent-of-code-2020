require_relative 'advent_data'

data = AdventData.new(day: 6, session: ARGV[0]).get

group_answers = [[]]

data.each { |string| string == '' ? group_answers << [] : group_answers.last << string.chars }

intersection_sum = 0

group_answers.each do |group_answer|
  intersection = group_answer.first

  group_answer.each { |answer| intersection &= answer }

  intersection_sum += intersection.length
end

puts intersection_sum
