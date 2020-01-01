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

def min_distance(indexed_positions, keys, blockers, source, cache = {})
  distances_to_keys = indexed_positions[source].reject do |v|
    !keys.include?(v.first) || v.last.any? { |b| blockers.include?(b) }
  end

  cache_key = "#{source.join}-#{distances_to_keys.flat_map(&:first).join}"
  cache[cache_key] = 0 if keys.empty?

  unless cache[cache_key]
    distances = []
    distances_to_keys.each do |key_data|
      distances << key_data[1] + min_distance(
        indexed_positions,
        keys - [key_data[0]],
        blockers - [key_data[2]],
        key_data[0],
        cache
      )
      cache[cache_key] = distances.min
    end
  end

  cache[cache_key]
end

def process(data)
  positions = data.select { |k, v| v != '#' }
  keys = data.select { |k, v| ('a'..'z').include?(v) }.keys
  doors = data.select { |k, v| ('A'..'Z').include?(v) }.keys

  indexed_positions = bfs(positions, keys + [data.key('@')], doors)
  min_distance(indexed_positions, keys, doors, data.key('@'))
end

def input
  File.readlines('./input.txt').flat_map.with_index do |line, j|
    line.strip.split('').map.with_index { |v, i| [[i, j], v] }
  end.to_h
end

puts process(input)
