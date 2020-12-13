require_relative 'advent_data'
require 'pry'

DIRECTION = { north: { row: '-' }, east: { column: '+' }, south: { row: '+' }, west: { column: '-' } }

data = AdventData.new(day: 11, session: ARGV[0]).get
@seats_grid = data.map { |string| string.chars.map { |seat| seat == 'L' ? 0 : nil } }

def in_borders?(row_number, seat_number)
  row_number >= 0 && row_number < @seats_grid.length &&
    seat_number >= 0 && seat_number < @seats_grid.first.length
end

def look(row_number, seat_number, step, direction)
  visible_seat = nil

  current_row_number = row_number
  current_seat_number = seat_number

  while visible_seat == nil
    current_row_number = current_row_number + (direction[:row] + '1').to_i if direction[:row]
    current_seat_number = current_seat_number + (direction[:column] + '1').to_i if direction[:column]

    break unless in_borders?(current_row_number, current_seat_number)

    visible_seat = step[current_row_number][current_seat_number]
  end

  visible_seat
end

def visible_sum(row_number, seat_number, step)
  visible = []

  visible << look(row_number, seat_number, step, DIRECTION[:north])
  visible << look(row_number, seat_number, step, DIRECTION[:north].merge(DIRECTION[:east]))
  visible << look(row_number, seat_number, step, DIRECTION[:east])
  visible << look(row_number, seat_number, step, DIRECTION[:south].merge(DIRECTION[:east]))
  visible << look(row_number, seat_number, step, DIRECTION[:south])
  visible << look(row_number, seat_number, step, DIRECTION[:south].merge(DIRECTION[:west]))
  visible << look(row_number, seat_number, step, DIRECTION[:west])
  visible << look(row_number, seat_number, step, DIRECTION[:north].merge(DIRECTION[:west]))

  visible.compact.sum
end

previous_step = []
current_step = @seats_grid

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
        visible_sum(row_number, seat_number, previous_step) == 0 ? new_value = 1 : new_value = 0
        current_step.last << new_value
      when 1
        visible_sum(row_number, seat_number, previous_step) >= 5 ? new_value = 0 : new_value = 1
        current_step.last << new_value
      end
    end
  end
end

puts current_step.map { |row| row.compact.sum }.sum
