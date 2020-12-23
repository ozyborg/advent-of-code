def edges(tile)
  edges = [
    tile.first,
    tile.map { |xs| xs.last },
    tile.last,
    tile.map { |xs| xs.first }
  ].map(&:join)

  edges + edges.map(&:reverse)
end

def rotate(tile, r)
  r.times { tile = tile.transpose.map(&:reverse) } and tile
end

def flip(tile)
  tile.map(&:reverse)
end

def align(tile, top)
  top_pos = edges(tile).index(top)

  tile = rotate(tile, 4 - top_pos % 4)
  tile = flip(tile) if [2, 3, 4, 5].include?(top_pos)

  tile
end

def process(data)
  tiles = data.map do |d|
    id, tile = d.split(":\n")
    id = id.split('Tile ').last.to_i
    tile = tile.split("\n").map { |xs| xs.chars }

    [id, { id: id, tile: tile, edges: edges(tile) }]
  end.to_h

  outer_edges = []

  tiles.each do |k0, t0|
    t_edges = t0[:edges]

    tiles.each do |k1, t1|
      next if k0 == k1
      t_edges -= t1[:edges]
      next if t_edges.empty?
    end

    outer_edges += t_edges
  end

  grid = {}

  grid[[0, 0]] = tiles.find { |k, t| (t[:edges] & outer_edges).size == 4 }.last

  grid_size = Math.sqrt(data.size).to_i

  grid_size.times do |x|
    grid_size.times do |y|
      tiles.delete(grid[[x, y]][:id])

      corner_edges = grid[[x, y]][:edges] & outer_edges

      top_edge = if x == 0
        left_edges = if y == 0
          corner_edges
        else
          [grid[[x, y - 1]][:edges][1]]
        end

        corner_edges.find do |c|
          tile = align(grid[[x, y]][:tile], c)
          left_edges.include?(edges(tile)[3])
        end
      else
        grid[[x - 1, y]][:edges][2]
      end

      grid[[x, y]][:tile] = align(grid[[x, y]][:tile], top_edge)
      grid[[x, y]][:edges] = edges(grid[[x, y]][:tile])

      tiles.each do |id, t|
        if t[:edges].include?(grid[[x, y]][:edges][1])
          grid[[x, y + 1]] = t
        end

        if t[:edges].include?(grid[[x, y]][:edges][2])
          grid[[x + 1, y]] = t
        end

        break if grid[[x, y + 1]] && grid[[x + 1, y]]
      end
    end
  end

  image = (8 * grid_size).times.map.with_index do |i|
    grid_size.times.map do |j|
      grid[[i / 8, j]][:tile][i % 8 + 1][1..-2]
    end.flatten(1)
  end

  sea_monster = [
    '                  # ',
    '#    ##    ##    ###',
    ' #  #  #  #  #  #   '
  ]
  sm_cols = sea_monster.first.size
  sm_rows = sea_monster.size
  sm_count = sea_monster.join.count('#')
  sm_regexp = Regexp.new(sea_monster.join.gsub(' ', '.'))

  (0..3).to_a.product([true, false]) do |rotate, flip|
    version = rotate(image, rotate)
    version = flip(version) if flip

    hash_count = 0

    version.each_cons(sm_rows) do |rows|
      rows.map { |r| r.each_cons(sm_cols).to_a }.transpose.each do |sm|
        hash_count += sm_count if sm.join.match(sm_regexp)
      end
    end

    return image.join.count('#') - hash_count if hash_count > 0
  end
end

def input
  File.read('./input.txt').split("\n\n")
end

puts process(input)
