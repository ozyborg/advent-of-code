def execute(memory)
  pointer = 0

  loop do
    opcode = memory[pointer]
    break if opcode == 99

    p1 = memory[memory[pointer + 1]]
    p2 = memory[memory[pointer + 2]]

    memory[memory[pointer + 3]] = case opcode
    when 1
      p1 + p2
    when 2
      p1 * p2
    end

    pointer += 4
  end
end

def process(data)
  (0..99).to_a.permutation(2).each do |i1, i2|
    program = data.dup
    program[1] = i1
    program[2] = i2
    execute(program)

    break 100 * i1 + i2 if program[0] == 19690720
  end
end

def input
  File.read('./input.txt').split(',').map(&:to_i)
end

puts process(input)
