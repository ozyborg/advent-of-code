def process(data)
  tiles = {}

  data.each do |d|
    id, tile = d.split(":\n")

    id = id.split('Tile ').last.to_i

    tile = tile.split("\n").map { |xs| xs.chars }

    edges = [
      tile.first,
      tile.map { |xs| xs.last },
      tile.last,
      tile.map { |xs| xs.first }
    ].map(&:join)

    possible_edges = edges.map do |edge|
      [edge, edge.reverse]
    end.flatten(1)

    tiles[id] = {
      id: id,
      possible_edges: possible_edges
    }
  end

  corners = tiles.select do |k0, t0|
    tiles.count { |k1, t1| (t0[:possible_edges] - t1[:possible_edges]).size == 6 } == 2
  end

  corners.values.map { |c| c[:id] }.reduce(:*)
end

def input
  File.read('./input.txt').split("\n\n")
end

puts process(input)
