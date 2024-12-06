def input
  File.read('./inputs/06.txt')
end

def data
  input.split("\n").flat_map.with_index do |line, row|
    line.chars.map.with_index do |ch, col|
      [[col, row], ch]
    end
  end.to_h
end

NEXT_DIRECTION = {
  [0, -1] => [1, 0],
  [1, 0] => [0, 1],
  [0, 1] => [-1, 0],
  [-1, 0] => [0, -1]
}

def visit_count(map, start)
  current_pos = start
  direction = [0, -1]
  visited = {}

  loop do
    visited[current_pos] ||= []

    break Float::INFINITY if visited[current_pos].include?(direction)

    visited[current_pos] << direction

    next_pos = current_pos.zip(direction).map(&:sum)

    if map[next_pos] == '#'
      direction = NEXT_DIRECTION[direction]
    else
      current_pos = next_pos
    end

    break visited.count if map[current_pos].nil?
  end
end

def part_1
  start = data.find { |k, v| v == '^' }.first

  visit_count(data, start)
end

def part_2
  start = data.find { |k, v| v == '^' }.first

  data.count do |k, v|
    next if v == '#' || k == start

    visit_count(data.merge(k => '#'), start) == Float::INFINITY
  end
end

puts "Part 1: #{part_1}"
puts "Part 2: #{part_2}"