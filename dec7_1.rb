require_relative 'advent_data'

data = AdventData.new(day: 7, session: ARGV[0]).get

def find_bag_options(bag_name, options)
  bigger_bag_names = @bag_dictionary.select { |name, contents| contents.include?(bag_name) }.keys

  options << bigger_bag_names

  bigger_bag_names.each do |bigger_bag_name|
    find_bag_options(bigger_bag_name, options)
  end

  options
end

@bag_dictionary = {}

data.each do |bag_rule|
  bag_rule = bag_rule.gsub('bags', '').delete(' ')

  bag_name, bag_contents = bag_rule.split('contain')

  @bag_dictionary[bag_name] = bag_contents
end

puts find_bag_options('shinygold', []).flatten.uniq.length
