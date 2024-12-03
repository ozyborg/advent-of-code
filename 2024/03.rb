def input
  File.read('./inputs/03.txt')
end

def data
  input
end

def mul_instructions
  data.scan(/mul\(\d+,\d+\)/)
end

def all_instructions
  data.scan(/mul\(\d+,\d+\)|do\(\)|don\'t\(\)/)
end

def mul(exp)
  exp.scan(/\d+/).map(&:to_i).reduce(:*)
end

def special_instruction?(ins)
  ins == "do()" || ins == "don't()"
end

def part_1
  mul_instructions.sum { |d| mul(d) }
end

def part_2
  current = "do()"

  all_instructions.inject(0) do |res, d|
    current = d if special_instruction?(d)

    next res if current == "don't()" || special_instruction?(d)

    res + mul(d)
  end
end

puts "Part 1: #{part_1}"
puts "Part 2: #{part_2}"
