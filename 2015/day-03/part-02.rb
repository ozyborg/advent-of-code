def process(data)
  char_map = {
    '^' => [0, 1],
    '>' => [1, 0],
    'v' => [0, -1],
    '<' => [-1, 0]
  }

  s_current = [0, 0]
  r_current = [0, 0]
  visited = { [0, 0] => true }

  data.each_with_index do |d, i|
    if i % 2 == 0
      s_current = [s_current, char_map[d]].transpose.map(&:sum)
      visited[s_current] = true
    else
      r_current = [r_current, char_map[d]].transpose.map(&:sum)
      visited[r_current] = true
    end
  end

  visited.size
end

def input
  File.read(ARGV.first).chomp.chars
end

puts process(input)

