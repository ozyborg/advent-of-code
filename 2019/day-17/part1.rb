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

  position_values = {}
  x, y = 0, 0

  loop do
    execute(program, stack)
    value = stack.pop
    break if value.nil?

    if value == 10
      x = 0
      y += 1
    else
      position_values[[x, y]] = value.chr
      x += 1
    end
  end

  intersections = position_values.select do |k, v|
    c = [k[0], k[1]]
    n = [k[0], k[1] + 1]
    w = [k[0] - 1, k[1]]
    s = [k[0], k[1] - 1]
    e = [k[0] + 1, k[1]]
    [c, n, w, s, e].all? { |v| position_values[v] == '#' }
  end

  intersections.inject(0) do |sum, k|
    sum + k.first.reduce(:*)
  end
end

def input
  File.read('./input.txt').split(',').map(&:to_i)
end

puts process(input)
