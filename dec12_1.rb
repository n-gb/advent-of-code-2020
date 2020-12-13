require_relative 'advent_data'

DIRECTION_MAP = { 0 => 'E', 90 => 'N', 180 => 'W', 270 => 'S' }

data = AdventData.new(day: 12, session: ARGV[0]).get

def move(cardinal_direction, number)
  case cardinal_direction
  when 'N'
    @y_axis += number
  when 'S'
    @y_axis -= number
  when 'E'
    @x_axis += number
  when 'W'
    @x_axis -= number
  end
end

@y_axis = 0
@x_axis = 0
ship_direction = 0

data.each do |instruction|
  direction, number = instruction.scan(/\D+|\d+/)

  case direction
  when 'L'
    ship_direction = (ship_direction + number.to_i) % 360
  when 'R'
    ship_direction = (ship_direction - number.to_i) % 360
  when 'F'
    move(DIRECTION_MAP[ship_direction], number.to_i)
  else
    move(direction, number.to_i)
  end
end

puts @y_axis.abs + @x_axis.abs
