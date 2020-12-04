require_relative 'advent_data'
require 'pry'

REQUIRED_FIELDS = ['byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid']
EYE_COLOURS = ['amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth']

data = AdventData.new(day: 4, session: ARGV[0]).get

def hashify(passport_string)
  passport_elements = passport_string.split(' ')

  passport_elements.each_with_object({}) do |element, hash|
    key, value = element.split(':')
    hash[key] = value
  end
end

def valid_height?(height)
  value, unit = height.split(/(?<=\d)(cm|in)/)

  return unless unit

  case unit
  when 'cm'
    value.to_i.between?(150, 193)
  when 'in'
    value.to_i.between?(59, 76)
  end
end

passports = [{}]

data.each { |string| string == '' ? passports << {} : passports.last.merge!(hashify(string)) }

valid_passwords = 0

passports.each do |passport|
  next unless (passport.keys & REQUIRED_FIELDS).sort == REQUIRED_FIELDS.sort
  next unless passport['byr'].to_i.between?(1920, 2002)
  next unless passport['iyr'].to_i.between?(2010, 2020)
  next unless passport['eyr'].to_i.between?(2020, 2030)
  next unless valid_height?(passport['hgt'])
  next unless /^#[0-9a-f]{6}$/.match? passport['hcl']
  next unless EYE_COLOURS.include? passport['ecl']
  next unless passport['pid'].length == 9

  valid_passwords += 1
end

puts valid_passwords
