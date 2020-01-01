def trace(orbital_map, k)
  return [] unless orbital_map.key?(k)

  [orbital_map[k]] + trace(orbital_map, orbital_map[k])
end

def process(data)
  data.keys.inject(0) { |acc, o| acc + trace(data, o).size }
end

def input
  File.readlines('./input.txt').map do |line|
    line.strip.split(')').reverse
  end.to_h
end

puts process(input)
