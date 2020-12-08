def process(data)
  pointer = 0
  acc = 0
  history = []
  changed = []
  can_be_changed = true

  loop do
    break if pointer == data.size

    if history.include?(pointer)
      pointer = 0
      acc = 0
      history = []
      can_be_changed = true
    end

    opcode, arg = data[pointer].split(' ')
    arg = arg.to_i

    if (opcode == 'nop' || opcode == 'jmp') && !changed.include?(pointer) && can_be_changed
      opcode = 'jmp' if opcode == 'nop'
      opcode = 'nop' if opcode == 'jmp'
      changed << pointer
      can_be_changed = false
    end

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
