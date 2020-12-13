require_relative 'advent_data'

data = AdventData.new(day: 12, session: ARGV[0]).get

def orientation_change(degrees)
  case degrees
  when 90
    @waypoint_coordinates.reverse!
    @waypoint_coordinates[0] = -@waypoint_coordinates[0]
  when 180
    @waypoint_coordinates[0] = -@waypoint_coordinates[0]
    @waypoint_coordinates[1] = -@waypoint_coordinates[1]
  when 270
    @waypoint_coordinates.reverse!
    @waypoint_coordinates[1] = -@waypoint_coordinates[1]
  end
end

ship_coordinates = [0, 0]
@waypoint_coordinates = [10, 1]

data.each do |instruction|
  direction, number = instruction.scan(/\D+|\d+/)

  case direction
  when 'N'
    @waypoint_coordinates[1] += number.to_i
  when 'S'
    @waypoint_coordinates[1] -= number.to_i
  when 'E'
    @waypoint_coordinates[0] += number.to_i
  when 'W'
    @waypoint_coordinates[0] -= number.to_i
  when 'L'
    ship_direction = orientation_change(number.to_i)
  when 'R'
    ship_direction = orientation_change(-number.to_i % 360)
  when 'F'
    ship_coordinates[0] += number.to_i * @waypoint_coordinates[0]
    ship_coordinates[1] += number.to_i * @waypoint_coordinates[1]
  end
end

puts ship_coordinates[0].abs + ship_coordinates[1].abs
