require_relative 'advent_data'

data = AdventData.new(day: 2, session: ARGV[0]).get

def split_the_data(password_data)
  data = password_data.split(' ')
  password = data[2]

  [prepare_range(data[0]), prepare_letter(data[1]), password]
end

def prepare_range(data)
  min, max = data.split('-').map(&:to_i)
  (min..max)
end

def prepare_letter(data)
  data.chomp(':')
end

valid_passwords = 0

data.each do |password_data|
  range, letter, password = split_the_data(password_data)

  if range === password.scan(letter).count
    valid_passwords += 1
  end
end

puts valid_passwords
