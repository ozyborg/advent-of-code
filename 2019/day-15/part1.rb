def possible_paths(points, source, destination, visited = [source])
  return [visited] if source == destination

  next_points = [
    [source[0], source[1] + 1],
    [source[0], source[1] - 1],
    [source[0] + 1, source[1]],
    [source[0] - 1, source[1]]
  ].select { |p| !visited.include?(p) && points.include?(p) }

  next_points.flat_map do |p|
    possible_paths(points, p, destination, visited + [p])
  end
end

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

  area_map = {}
  x, y = 0, 0
  direction = 1

  oxygen_system_position = loop do
    stack.push(direction)
    execute(program, stack)
    status = stack.pop

    next_x, next_y = x, y
    case direction
    when 1
      next_y += 1
    when 2
      next_y -= 1
    when 3
      next_x -= 1
    when 4
      next_x += 1
    end
    area_map[[next_x, next_y]] = status

    case status
    when 1
      x, y = next_x, next_y
    when 2
      break [x, y]
    end

    direction = loop do
      d = rand(1..4)
      possible_position = case d
      when 1
        [x, y + 1]
      when 2
        [x, y - 1]
      when 3
        [x - 1, y]
      when 4
        [x + 1, y]
      end
      break d unless area_map[possible_position] == 0
    end
  end

  possible_paths(
    area_map.reject { |k, v| v == 0 }.keys,
    [0, 0],
    oxygen_system_position
  ).map(&:size).min
end

def input
  File.read('./input.txt').split(',').map(&:to_i)
end

puts process(input)
