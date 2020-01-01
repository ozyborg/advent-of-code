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
  programs = 50.times.map { |i| [i, data.dup + Array.new(1000){0}] }.to_h
  queues = 50.times.map { |i| [i, []] }.to_h
  stack = []

  50.times do |i|
    stack.push(i)
    execute(programs[i], stack)
  end

  loop do
    res = nil

    50.times do |i|
      if queues[i].empty?
        stack.push(-1)
      else
        stack.push(queues[i].pop)
        stack.push(queues[i].pop)
      end
      execute(programs[i], stack)
      next if stack.empty?

      address = stack.pop
      execute(programs[i], stack)
      x = stack.pop
      execute(programs[i], stack)
      y = stack.pop

      if address == 255
        res = y
        break
      else
        queues[address].unshift(y)
        queues[address].unshift(x)
      end
    end

    break res if res
  end
end

def input
  File.read('./input.txt').split(',').map(&:to_i)
end

puts process(input)
