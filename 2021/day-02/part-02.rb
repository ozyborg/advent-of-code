def process(data)
  x, y, aim = 0, 0, 0

  data.each do |d, u|
    case d
    when 'forward'
      x += u
      y += aim * u
    when 'down'
      aim += u
    when 'up'
      aim -= u
    end
  end

  x * y
end

def input
  File.read(ARGV.first).scan(/(\w+) (\w+)\n/).map { |c1, c2| [c1, c2.to_i] }
end

puts process(input)

