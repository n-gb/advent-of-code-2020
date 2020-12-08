require_relative 'advent_data'

@original_data = AdventData.new(day: 8, session: ARGV[0]).get

def execute(line)
  return true unless @data[line]
  return false if @history.include?(line)

  @history << line

  instruction = @data[line]
  operation, argument = instruction.split(' ')

  case operation
  when 'acc'
    @acc += argument.to_i
    execute(line + 1)
  when 'jmp'
    execute(line + argument.to_i)
  when 'nop'
    execute(line + 1)
  end
end

@original_data.each_with_index do |instruction, line|
  next if instruction.include?('acc')

  @history = []
  @acc = 0
  @data = @original_data.dup

  @data[line] = instruction.include?('nop') ? instruction.gsub('nop', 'jmp') : instruction.gsub('jmp', 'nop')

  break if execute(0)
end

p @acc
