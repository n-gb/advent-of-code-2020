require_relative 'advent_data'

data = AdventData.new(day: 2, session: ARGV[0]).get

def prepare_the_data(password_data)
  data = password_data.split(' ')
  password = data[2]

  [prepare_positions(data[0]), prepare_letter(data[1]), password].flatten
end

def prepare_positions(data)
  data.split('-').map(&:to_i)
end

def prepare_letter(data)
  data.chomp(':')
end

valid_passwords = 0

data.each do |password_data|
  first_position, second_position, letter, password = prepare_the_data(password_data)

  if (password[first_position - 1] == letter) ^ (password[second_position - 1] == letter)
    valid_passwords += 1
  end
end

puts valid_passwords
