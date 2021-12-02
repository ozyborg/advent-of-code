def process(data)
  x, y = 0, 0

  data.each do |d, u|
    case d
    when 'forward'
      x += u
    when 'down'
      y += u
    when 'up'
      y -= u
    end
  end

  x * y
end

def input
  File.read(ARGV.first).scan(/(\w+) (\w+)\n/).map { |c1, c2| [c1, c2.to_i] }
end

puts process(input)

