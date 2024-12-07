def input
  File.read('./inputs/07.txt')
end

def data
  input.split("\n").map do |line|
    result, values = line.split(': ')

    [result.to_i, values.split(' ')]
  end
end

def valid?(result, values, operators)
  operators.repeated_permutation(values.length - 1).any? do |ops|
    numbers = values.dup

    ops.each do |op|
      operands = numbers.shift(2)
      numbers.unshift(eval(operands.join(op)))
    end

    numbers.first == result
  end
end

def part_1
  data.select do |d|
    valid?(d.first, d.last, ['+', '*'])
  end.sum(&:first)
end

def part_2
  data.select do |d|
    valid?(d.first, d.last, ['+', '*', ''])
  end.sum(&:first)
end

puts "Part 1: #{part_1}"
puts "Part 2: #{part_2}"