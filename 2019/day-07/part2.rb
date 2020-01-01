def execute(memory, stack)
  pointer = memory.pop

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
    end
  end

  memory.push(pointer)
end

def process(data)
  (5..9).to_a.permutation(5).map do |perm|
    programs = perm.map { |i| [i, data.dup + Array.new(1000){0}] }.to_h
    stack = [0]

    perm.each do |i|
      stack.push(i)
      execute(programs[i], stack)
    end

    loop do
      break if stack.last.nil?
      perm.each do |i|
        execute(programs[i], stack)
      end
    end

    stack.first
  end.max
end

def input
  File.read('./input.txt').split(',').map(&:to_i)
end

puts process(input)
