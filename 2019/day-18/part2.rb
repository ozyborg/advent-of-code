def bfs(positions, keys, doors)
  result = {}
  keys.each do |key|
    queue = [[key, []]]
    distances = {key => 0}
    key_paths = []
    while queue.size > 0
      position, blockers = queue.shift
      next_positions = [
        [position[0], position[1] + 1],
        [position[0], position[1] - 1],
        [position[0] + 1, position[1]],
        [position[0] - 1, position[1]]
      ].reject { |p| distances.key?(p) || positions[p] == '#' || !positions[p] }
      next_positions.each do |p|
        distances[p] = distances[position] + 1
        if keys.include?(p)
          key_paths << [p, distances[p], positions.key(positions[p].upcase), blockers]
        end
        if doors.include?(p)
          queue << [p, blockers + [p]]
        else
          queue << [p, blockers]
        end
      end
      if keys.include?(position)
        result[key] = key_paths
      end
    end
  end
  result
end

def min_distance(indexed_positions, keys, blockers, sources, cache = {})
  distances_to_keys = sources.map do |s|
    indexed_positions[s].reject do |v|
      !keys.include?(v.first) || v.last.any? { |b| blockers.include?(b) }
    end
  end

  cache_key = "#{sources.join}-#{distances_to_keys.map{|s| s.flat_map(&:first)}.join}"
  cache[cache_key] = 0 if keys.empty?

  unless cache[cache_key]
    distances = []
    sources.each.with_index do |s, i|
      distances_to_keys[i].each do |key_data|
        next_sources = sources.dup
        next_sources[i] = key_data[0]
        distances << key_data[1] + min_distance(
          indexed_positions,
          keys - [key_data[0]],
          blockers - [key_data[2]],
          next_sources,
          cache
        )
        cache[cache_key] = distances.min
      end
    end
  end

  cache[cache_key]
end

def process(data)
  positions = data.select { |k, v| v != '#' }

  center = data.key('@')
  substitute_keys = ['!', '@', '#', '$']
  substitute_key_positions = []
  [-1, 0, 1].repeated_permutation(2).each do |i, j|
    position = [center[0] + i, center[1] + j]
    value = if (i + j).abs == 1
      '#'
    else
      substitute_key_positions << position
      substitute_keys.shift
    end
    positions[position] = value
  end

  keys = data.select { |k, v| ('a'..'z').include?(v) }.keys
  doors = data.select { |k, v| ('A'..'Z').include?(v) }.keys

  indexed_positions = bfs(positions, keys + substitute_key_positions, doors)
  min_distance(indexed_positions, keys, doors, substitute_key_positions)
end

def input
  File.readlines('./input.txt').flat_map.with_index do |line, j|
    line.strip.split('').map.with_index { |v, i| [[i, j], v] }
  end.to_h
end

puts process(input)
