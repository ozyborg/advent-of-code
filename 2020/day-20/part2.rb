def possible_edges(tile)
  [
    tile.first,
    tile.map { |xs| xs.last },
    tile.last,
    tile.map { |xs| xs.first }
  ].map(&:join)
   .map { |edge| [edge, edge.reverse] }
   .flatten(1)
end

def transform_tile(tile, rotate, flip)
  next_tile = tile

  rotate.times do
    next_tile = next_tile.transpose.map(&:reverse)
  end

  next_tile = next_tile.map(&:reverse) if flip

  next_tile
end

def align_tile(tile, top)
  position = tile[:possible_edges].index(top)

  transform_tile(tile[:tile], (4 - position / 2) % 4, [1, 3, 4, 6].include?(position))
end

def process(data)
  tiles = {}

  data.each do |d|
    id, tile = d.split(":\n")

    id = id.split('Tile ').last.to_i

    tile = tile.split("\n").map { |xs| xs.chars }

    tiles[id] = {
      id: id,
      tile: tile,
      possible_edges: possible_edges(tile)
    }
  end

  corners = tiles.select do |k0, t0|
    tiles.count { |k1, t1| (t0[:possible_edges] - t1[:possible_edges]).size == 6 } == 2
  end

  grid = {}

  grid[[0, 0]] = corners.first[1]

  grid_size = Math.sqrt(data.size).to_i

  all_possible_edges = tiles.transform_values { |v| v[:possible_edges] }.to_h

  grid_size.times do |x|
    grid_size.times do |y|
      tiles.delete(grid[[x, y]][:id])

      top_edge = nil
      if x == 0
        unique_edges = grid[[x, y]][:possible_edges].select do |p_edge|
          all_possible_edges.none? { |k, edges| k != grid[[x, y]][:id] && edges.include?(p_edge) }
        end
        if y == 0
          tile = align_tile(grid[[x, y]], unique_edges[0])
          if unique_edges.include?(possible_edges(tile)[6])
            top_edge = unique_edges[0]
          else
            top_edge = unique_edges[1]
          end
        elsif y == 11
          unique_edges.size.times.each do |i|
            tile = align_tile(grid[[x, y]], unique_edges[i])
            if grid[[x, y - 1]][:possible_edges][2] == possible_edges(tile)[6]
              top_edge = unique_edges[i]
              break
            end
          end
        else
          top_edge = unique_edges.first
        end
      else
        top_edge = grid[[x - 1, y]][:possible_edges][4]
      end

      grid[[x, y]][:tile] = align_tile(grid[[x, y]], top_edge)
      grid[[x, y]][:possible_edges] = possible_edges(grid[[x, y]][:tile])

      if y > 0 && grid[[x, y]][:possible_edges][6] != grid[[x, y - 1]][:possible_edges][2]
        grid[[x, y]][:tile] = transform_tile(grid[[x, y]][:tile], 0, true)
        grid[[x, y]][:possible_edges] = possible_edges(grid[[x, y]][:tile])
      end

      tiles.each do |id, t|
        if t[:possible_edges].include?(grid[[x, y]][:possible_edges][2])
          grid[[x, y + 1]] = t
        end

        if t[:possible_edges].include?(grid[[x, y]][:possible_edges][4])
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
    '                  # '.chars.map.with_index { |ch, i| ch == '#' ? i : nil }.compact,
    '#    ##    ##    ###'.chars.map.with_index { |ch, i| ch == '#' ? i : nil }.compact,
    ' #  #  #  #  #  #   '.chars.map.with_index { |ch, i| ch == '#' ? i : nil }.compact
  ]
  sea_monster_row_size = '                  # '.length

  (0..3).to_a.product([true, false]) do |rotate, flip|
    version = transform_tile(image, rotate, flip)

    hash_count = 0
    offset = version.first.size - sea_monster_row_size

    version.each_cons(sea_monster.size) do |rows|
      offset.times do |i|
        contains = rows.map { |row| row.drop(i) }
                       .map.with_index do |row, row_i|
                         sea_monster[row_i].all? { |s| row[s] == '#' }
                       end.all?
        hash_count += sea_monster.flatten(1).size if contains
      end
    end

    if hash_count > 0
      return image.join.count('#') - hash_count
    end
  end
end

def input
  File.read('./input.txt').split("\n\n")
end

puts process(input)
