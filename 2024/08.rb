def input
  File.read('./inputs/08.txt')
end

def data
  input.split("\n").flat_map.with_index do |line, row|
    line.chars.map.with_index do |ch, col|
      [[col, row], ch]
    end
  end.to_h
end

def freqs(data)
  data.each_with_object({}) do |(k, v), hash|
    next if v == '.'

    hash[v] ||= []
    hash[v] << k
  end
end

def part_1
  antinodes = []

  freqs(data).each do |freq, coords|
    coords.permutation(2).each do |(x1, y1), (x2, y2)|
      dx = x2 - x1
      dy = y2 - y1

      antinode = [x1 - dx, y1 - dy]

      antinodes << antinode if data[antinode]
    end
  end

  antinodes.uniq.count
end

def part_2
  antinodes = []

  freqs(data).each do |freq, coords|
    coords.permutation(2).each do |(x1, y1), (x2, y2)|
      dx = x2 - x1
      dy = y2 - y1

      (1..).each do |step|
        antinode = [x2 - (dx * step), y2 - (dy * step)]

        break if data[antinode].nil?

        antinodes << antinode
      end
    end
  end

  antinodes.uniq.count
end

puts "Part 1: #{part_1}"
puts "Part 2: #{part_2}"