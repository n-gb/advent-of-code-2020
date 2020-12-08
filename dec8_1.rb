require_relative 'advent_data'

@data = AdventData.new(day: 8, session: ARGV[0]).get

@history = ''
@acc = 0

def execute(line)
  instruction = @data[line]
  operation, argument = instruction.split(' ')

  return @acc if @history.include?(".#{line}.")

  @history += ".#{line}."

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

execute(0)

puts @acc
