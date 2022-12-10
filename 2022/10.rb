def part_2(data)
  x = 1
  cycle = 0

  pixels = Array.new(6 * 40) { '.' }

  data.each do |cmd, p1|
    pixels[cycle] = '#' if (x - 1..x + 1).include?(cycle % 40)
    case cmd
    when 'noop'
      cycle += 1
    when 'addx'
      cycle += 1
      pixels[cycle] = '#' if (x - 1..x + 1).include?(cycle % 40)
      cycle += 1
      x += p1.to_i
    end
  end

  pixels.each_slice(40).map(&:join)
end

def part_1(data)
  x = 1
  cycle = 1
  cycles = [20, 60, 100, 140, 180, 220]

  ss = []

  data.each do |cmd, p1|
    ss << x * cycle if cycles.include?(cycle)
    case cmd
    when 'noop'
      cycle += 1
    when 'addx'
      cycle += 1
      ss << x * cycle if cycles.include?(cycle)
      cycle += 1
      x += p1.to_i
    end
  end

  ss.sum
end

def input
  File.read('./inputs/10.txt').split("\n").map { |l| l.split(' ') }
end

puts part_1(input)
puts part_2(input)
