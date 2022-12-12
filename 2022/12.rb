DELTAS = [
  [1, 0],
  [0, 1],
  [-1, 0],
  [0, -1]
]

def shortest_path(map, from, to)
  queue = [[from, 0]]
  visited = { from => true }

  while queue.any?
    current, steps = queue.shift

    break steps if current == to

    adjs = DELTAS.map { |d| current.zip(d).map(&:sum) }

    adjs.each do |adj|
      next if map[adj].nil?
      next if visited[adj]
      next if map[adj].ord - map[current].ord > 1

      visited[adj] = true

      queue << [adj, steps + 1]
    end
  end
end

def part_2(data)
  s = data.key('S')
  e = data.key('E')

  data[s] = 'a'
  data[e] = 'z'

  data.select { |k, v| v == 'a' }.keys.map do |s|
    shortest_path(data, s, e)
  end.compact.min
end

def part_1(data)
  s = data.key('S')
  e = data.key('E')

  data[s] = 'a'
  data[e] = 'z'

  shortest_path(data, s, e)
end

def input
  File.read('./inputs/12.txt').split("\n").flat_map.with_index do |l, row|
    l.chars.map.with_index do |v, col|
      [[row, col], v]
    end
  end.to_h
end

puts part_1(input)
puts part_2(input)
