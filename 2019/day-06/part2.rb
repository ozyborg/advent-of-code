def trace(orbital_map, k)
  return [] unless orbital_map.key?(k)

  [orbital_map[k]] + trace(orbital_map, orbital_map[k])
end

def process(data)
  source_trace = trace(data, 'YOU')
  destination_trace = trace(data, 'SAN')

  crosspoint = (source_trace & destination_trace).first
  source_trace.index(crosspoint) + destination_trace.index(crosspoint)
end

def input
  File.readlines('./input.txt').map do |line|
    line.strip.split(')').reverse
  end.to_h
end

puts process(input)
