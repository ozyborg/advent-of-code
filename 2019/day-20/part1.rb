def bfs(positions, edge_positions, source, destination)
  result = nil

  queue = [source]
  distances = {source => 0}
  while queue.size > 0 && result.nil?
    position = queue.shift
    warp_step = 0
    next_positions = [
      [position[0], position[1] + 1],
      [position[0], position[1] - 1],
      [position[0] + 1, position[1]],
      [position[0] - 1, position[1]]
    ].reject do |p|
      distances.key?(p) || !positions[p]
    end.map do |p|
      value = positions[p]
      if value != '.' && edge_positions[value].size > 1
        warp_step = 1
        (edge_positions[value] - [p])[0]
      else
        p
      end
    end
    next_positions.each do |p|
      distances[p] = distances[position] + 1 + warp_step
      if p == destination
        result = distances[p]
        break
      end
      queue << p
    end
  end

  result
end

def process(data)
  positions = data.reject { |k, v| ['#', ' '].include?(v) }.to_h
  edges = {}
  positions.each do |k, v|
    n = positions.fetch([k[0], k[1] - 2], '.') + positions.fetch([k[0], k[1] - 1], '.')
    w = positions.fetch([k[0] - 2, k[1]], '.') + positions.fetch([k[0] - 1, k[1]], '.')
    s = positions.fetch([k[0], k[1] + 1], '.') + positions.fetch([k[0], k[1] + 2], '.')
    e = positions.fetch([k[0] + 1, k[1]], '.') + positions.fetch([k[0] + 2, k[1]], '.')
    edge = [n, w, s, e].find { |v| !v.include?('.') }
    edges[edge] = edges.fetch(edge, []) + [k] if edge
  end
  edges.each do |k, v|
    v.each do |p|
      positions[p] = k
    end
  end
  positions.reject! { |k, v| ('A'..'Z').include?(v) }
  bfs(positions, edges, positions.key('AA'), positions.key('ZZ'))
end

def input
  File.readlines('./input.txt').flat_map.with_index do |line, j|
    line.chomp.split('').map.with_index { |v, i| [[i, j], v] }
  end
end

puts process(input)
