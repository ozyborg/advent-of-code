def bfs(positions, edge_positions, source, destination)
  result = nil

  warp_edges = edge_positions.select { |k, v| v.size > 1 }.to_h
  min_x = warp_edges.values.flat_map { |v| v.flat_map { |p| p[0] } }.min
  min_y = warp_edges.values.flat_map { |v| v.flat_map { |p| p[1] } }.min
  max_x = warp_edges.values.flat_map { |v| v.flat_map { |p| p[0] } }.max
  max_y = warp_edges.values.flat_map { |v| v.flat_map { |p| p[1] } }.max
  outer_edges = warp_edges.map do |k, v|
    v.find { |p| p[0] == min_x || p[1] == min_y || p[0] == max_x || p[1] == max_y }
  end
  inner_edges = warp_edges.map do |k, v|
    v.find { |p| !outer_edges.include?(p) }
  end

  queue = [[source, 0]]
  distances = {[source, 0] => 0}
  while queue.size > 0 && result.nil?
    position, level = queue.shift
    warp_step = 0
    next_positions = [
      [position[0], position[1] + 1],
      [position[0], position[1] - 1],
      [position[0] + 1, position[1]],
      [position[0] - 1, position[1]]
    ].reject do |p|
      level > 25 ||
      distances.key?([p, level]) ||
      !positions[p] ||
      (level == 0 && outer_edges.include?(p)) ||
      (level != 0 && [source, destination].include?(p))
    end.map do |p|
      value = positions[p]
      if warp_edges.key?(value)
        warp_step = 1
        (warp_edges[value] - [p])[0]
      else
        p
      end
    end
    next_positions.each do |p|
      next_level = level
      next_level -= 1 if inner_edges.include?(p)
      next_level += 1 if outer_edges.include?(p)
      distances[[p, next_level]] = distances[[position, level]] + 1 + warp_step
      if p == destination
        result = distances[[p, next_level]]
        break
      end
      queue << [p, next_level] 
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
