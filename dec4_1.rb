require_relative 'advent_data'

REQUIRED_FIELDS = ['byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid']

data = AdventData.new(day: 4, session: ARGV[0]).get

def hashify(passport_string)
  passport_elements = passport_string.split(' ')

  passport_elements.each_with_object({}) do |element, hash|
    key, value = element.split(':')
    hash[key] = value
  end
end

passports = [{}]

data.each { |string| string == '' ? passports << {} : passports.last.merge!(hashify(string)) }

valid_passwords = passports.select do |passport|
  (passport.keys & REQUIRED_FIELDS).sort == REQUIRED_FIELDS.sort
end.length

puts valid_passwords
