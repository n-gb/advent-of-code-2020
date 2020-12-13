require_relative 'advent_data'

data = AdventData.new(day: 11, session: ARGV[0]).get

def adjacent_sum(row_number, seat_number, step)
  adjacent = []

  adjacent << step.dig(row_number, seat_number - 1) if seat_number > 0
  adjacent << step.dig(row_number, seat_number + 1) if seat_number < step.first.length - 1
  adjacent << step.dig(row_number - 1, seat_number - 1) if row_number > 0 && seat_number > 0
  adjacent << step.dig(row_number - 1, seat_number) if row_number > 0
  adjacent << step.dig(row_number - 1, seat_number + 1) if row_number > 0 && seat_number < step.first.length - 1
  adjacent << step.dig(row_number + 1, seat_number - 1) if row_number < step.length - 1 && seat_number > 0
  adjacent << step.dig(row_number + 1, seat_number) if row_number < step.length - 1
  adjacent << step.dig(row_number + 1, seat_number + 1) if row_number < step.length - 1 && seat_number < step.first.length - 1

  adjacent.compact.sum
end

array_of_seats = data.map { |string| string.chars.map { |seat| seat == 'L' ? 0 : nil } }

previous_step = []
current_step = array_of_seats

while previous_step != current_step do
  previous_step = current_step
  current_step = []

  previous_step.each_with_index do |row, row_number|
    current_step << []
    row.each_with_index do |seat, seat_number|
      case seat
      when nil
        current_step[row_number] << nil
      when 0
        adjacent_sum(row_number, seat_number, previous_step) == 0 ? new_value = 1 : new_value = 0
        current_step.last << new_value
      when 1
        adjacent_sum(row_number, seat_number, previous_step) >= 4 ? new_value = 0 : new_value = 1
        current_step.last << new_value
      end
    end
  end
end

puts current_step.map { |row| row.compact.sum }.sum
