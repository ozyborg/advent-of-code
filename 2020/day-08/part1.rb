def process(data)
  pointer = 0
  acc = 0
  history = []

  loop do
    break if history.include?(pointer)

    opcode, arg = data[pointer].split(' ')
    arg = arg.to_i

    history << pointer

    case opcode
    when 'nop'
      pointer += 1
    when 'acc'
      acc += arg
      pointer += 1
    when 'jmp'
      pointer += arg
    else
    end
  end

  acc
end

def input
  File.readlines('./input.txt')
end

puts process(input)
