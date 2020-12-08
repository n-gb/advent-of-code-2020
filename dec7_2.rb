require_relative 'advent_data'

data = AdventData.new(day: 7, session: ARGV[0]).get

def find_contained_bags(bag_name)
  contained_bags = @bag_dictionary[bag_name]

  return 0 if contained_bags.length == 0

  contained_bags.map { |bag_name, bag_count| bag_count + find_contained_bags(bag_name) * bag_count }.sum
end

@bag_dictionary = {}

data.each do |bag_rule|
  bag_rule = bag_rule.gsub(/bags?/, '').delete(' ')

  bag_name, bag_contents = bag_rule.split('contain')
  bag_contents = bag_contents.delete('.').split(',')

  bag_contents_hash = {}

  unless bag_contents.first.include?('noother')
    bag_contents.each do |bag|
      number, bag = bag.scan(/\d+|\D+/)
      bag_contents_hash[bag] = number.to_i
    end
  end

  @bag_dictionary[bag_name] = bag_contents_hash
end

puts find_contained_bags('shinygold')
