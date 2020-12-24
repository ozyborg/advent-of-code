def process(data)
  coord_sys = {
    'nw' => [0, 1],
    'ne' => [1, 1],
    'e' => [1, 0],
    'se' => [0, -1],
    'sw' => [-1, -1],
    'w' => [-1, 0]
  }

  tiles = {}

  data.each do |d|
    directions = d.scan(/nw|ne|e|se|sw|w/)

    next_tile = directions.inject([0, 0]) do |ref, d|
      [ref, coord_sys[d]].transpose.map(&:sum)
    end

    tiles[next_tile] ^= 1
  end

  tiles.count { |k, v| v }
end

def input
  File.readlines('./input.txt')
end

puts process(input)
