def count_paths(path, source, dest, history)
  history_key = "#{source}/#{path.join('-')}"

  return history[history_key] if history[history_key]

  possible_paths = 0

  possible_paths += 1 if dest - source <= 3

  return possible_paths if path.empty?

  head, *tail = path

  possible_paths += count_paths(tail, head, dest, history) if head - source <= 3
  possible_paths += count_paths(tail, source, dest, history)

  history[history_key] = possible_paths

  possible_paths
end

def process(data)
  count_paths(data.sort, 0, data.sort.last + 3, {})
end

def input
  File.readlines('./input.txt').map(&:to_i)
end

puts process(input)
