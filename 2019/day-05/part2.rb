def execute(memory, stack)
  pointer = 0

  loop do
    instruction = memory[pointer]

    opcode = instruction % 100
    break if opcode == 99

    p_addr = -> (p) do
      case (instruction / (10 ** (p + 1))) % 10
      when 0
        memory[pointer + p]
      when 1
        pointer + p
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
      memory[p_addr[1]] = stack.pop
      pointer += 2
    when 4
      stack.push(memory[p_addr[1]])
      pointer += 2
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
    end
  end
end

def process(data)
  program = data.dup
  stack = [5]
  execute(program, stack)
  stack.pop
end

def input
  File.read('./input.txt').split(',').map(&:to_i)
end

puts process(input)
