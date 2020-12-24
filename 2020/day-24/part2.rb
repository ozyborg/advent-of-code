def coord_sys
   {
  'nw' => [0, 1],
  'ne' => [1, 1],
  'e' => [1, 0],
  'se' => [0, -1],
  'sw' => [-1, -1],
  'w' => [-1, 0]
}
end

def adjacents(tile)
  coord_sys.values.map { |d| [tile, d].transpose.map(&:sum) }
end

def process(data)
  tiles = {}

  data.each do |d|
    directions = d.scan(/nw|ne|e|se|sw|w/)

    next_tile = directions.inject([0, 0]) do |ref, d|
      [ref, coord_sys[d]].transpose.map(&:sum)
    end

    tiles[next_tile] ^= 1
  end

  100.times do
    next_tiles = {}

    black_adj_counts = {}

    tiles.each do |k, v|
      if v
        adjacents(k).each do |adj|
          black_adj_counts[adj] = black_adj_counts.fetch(adj, 0) + 1
        end
      end
    end

    tiles.each do |k, v|
      black_count = black_adj_counts.fetch(k, 0)
      if v && (black_count == 0 || black_count > 2)
        next_tiles[k] = false
      else
        next_tiles[k] = v
      end
    end

    black_adj_counts.each do |k, v|
      next_tiles[k] = true if !tiles[k] && v == 2
    end

    tiles = next_tiles
  end

  tiles.count { |k, v| v }
end

def input
  File.readlines('./input.txt')
end

puts process(input)
