require_relative 'advent_data'

ROWS = (0..127).to_a
COLUMNS = (0..7).to_a

data = AdventData.new(day: 5, session: ARGV[0]).get

def select_the_seat_position(range, instructions, lower_selector, upper_selector)
  instructions.chars.each do |code_letter|
    lower, upper = range.each_slice(range.length/2).map(&:to_a)

    case code_letter
    when lower_selector
      range = lower
    when upper_selector
      range = upper
    end
  end

  range.first
end

taken_seat_ids = []

data.each do |seat_code|
  row = select_the_seat_position(ROWS, seat_code[0...7], 'F', 'B')
  column = select_the_seat_position(COLUMNS, seat_code[7...10], 'L', 'R')
  seat_id = row * 8 + column

  taken_seat_ids << seat_id
end

taken_seat_ids.sort!
all_seat_ids = (taken_seat_ids.first..taken_seat_ids.last).to_a

puts all_seat_ids - taken_seat_ids
