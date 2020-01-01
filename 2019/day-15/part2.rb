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
  explored = {}
  x, y = 0, 0
  direction = 1

  loop do
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

    if status == 0
      explored[[next_x, next_y]] = true
    else
      x, y = next_x, next_y
    end

    direction_values = {
      1 => area_map[[x, y + 1]],
      2 => area_map[[x, y - 1]],
      3 => area_map[[x - 1, y]],
      4 => area_map[[x + 1, y]]
    }
    if direction_values.values.all?
      explored[[x, y]] = true
      break if explored.size == area_map.size
    end
    direction = direction_values.select { |k, v| v != 0 }.keys.sample
  end

  oxygen_system_position = area_map.find { |k, v| v == 2 }.first
  open_positions_count = area_map.values.count { |v| v != 0 }
  oxygen_containing_positions = [oxygen_system_position]
  source_positions = [oxygen_system_position]

  acc = 0
  while oxygen_containing_positions.count < open_positions_count
    source_positions = source_positions.flat_map do |p|
      [
        [p[0], p[1] + 1],
        [p[0], p[1] - 1],
        [p[0] + 1, p[1]],
        [p[0] - 1, p[1]]
      ].select do |p|
        !oxygen_containing_positions.include?(p) && area_map[p] == 1
      end
    end
    oxygen_containing_positions += source_positions
    acc += 1
  end
  acc
end

def input
  File.read('./input.txt').split(',').map(&:to_i)
end

puts process(input)
