def process(data)
  char_map = {
    '^' => [0, 1],
    '>' => [1, 0],
    'v' => [0, -1],
    '<' => [-1, 0]
  }

  current = [0, 0]
  visited = { current => true }

  data.each do |d|
    current = [current, char_map[d]].transpose.map(&:sum)
    visited[current] = true
  end

  visited.size
end

def input
  File.read(ARGV.first).chomp.chars
end

puts process input

