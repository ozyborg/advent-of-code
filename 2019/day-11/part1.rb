def execute(memory, stack)
  pointer = memory.pop
  relative_base = memory.pop

  loop do
    instruction = memory[pointer]

    opcode = instruction % 100
    break stack.push(nil) if opcode == 99

    p_addr = -> (p) do
      case (instruction / (10 ** (p + 1))) % 10
      when 0
        memory[pointer + p]
      when 1
        pointer + p
      when 2
        relative_base + memory[pointer + p]
      end
    end

    case opcode
    when 1
      memory[p_addr[3]] = memory[p_addr[1]] + memory[p_addr[2]]
      pointer += 4
    when 2
      memory[p_addr[3]] = memory[p_addr[1]] * memory[p_addr[2]]
      pointer += 4
    when 3
      input = stack.pop
      break if input.nil?
      memory[p_addr[1]] = input
      pointer += 2
    when 4
      stack.push(memory[p_addr[1]])
      pointer += 2
      break
    when 5
      memory[p_addr[1]] != 0 ? pointer = memory[p_addr[2]] : pointer += 3
    when 6
      memory[p_addr[1]] == 0 ? pointer = memory[p_addr[2]] : pointer += 3
    when 7
      memory[p_addr[3]] = memory[p_addr[1]] < memory[p_addr[2]] ? 1 : 0
      pointer += 4
    when 8
      memory[p_addr[3]] = memory[p_addr[1]] == memory[p_addr[2]] ? 1 : 0
      pointer += 4
    when 9
      relative_base += memory[p_addr[1]]
      pointer += 2
    end
  end

  memory.push(relative_base)
  memory.push(pointer)
end

def process(data)
  program = data.dup + Array.new(1000){0}
  stack = []

  position_colors = {}
  x, y = 0, 0
  d = 'U'

  loop do
    position_colors[[x, y]] = [0] unless position_colors.key?([x, y])

    stack.push(position_colors[[x, y]].last)
    execute(program, stack)
    break if stack.last.nil?

    position_colors[[x, y]] << stack.pop
    execute(program, stack)
    direction = stack.pop

    case d
    when 'U'
      x += direction == 0 ? -1 : 1
      d = direction == 0 ? 'L' : 'R'
    when 'D'
      x += direction == 0 ? 1 : -1
      d = direction == 0 ? 'R' : 'L'
    when 'L'
      y += direction == 0 ? -1 : 1
      d = direction == 0 ? 'D' : 'U'
    when 'R'
      y += direction == 0 ? 1 : -1
      d = direction == 0 ? 'U' : 'D'
    end
  end

  position_colors.size
end

def input
  File.read('./input.txt').split(',').map(&:to_i)
end

puts process(input)
