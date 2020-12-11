def adjacents(data, y, x, d)
  n = y - d < 0 ? data.size : y - d
  s = y + d
  w = x - d < 0 ? data.first.size : x - d
  e = x + d

  [
    data.dig(n, w),
    data.dig(n, x),
    data.dig(n, e),
    data.dig(y, e),
    data.dig(s, e),
    data.dig(s, x),
    data.dig(s, w),
    data.dig(y, w)
  ]
end

def visible_count(data, y, x)
  seen = ['.'] * 8

  1.step.each do |d|
    adjs = adjacents(data, y, x, d)

    break if seen.none?('.') || adjs.all?(nil)

    8.times do |i|
      seen[i] = adjs[i] if seen[i] == '.'
    end
  end

  seen.count('#')
end

def next_value(data, y, x)
  value = data.dig(y, x)
  visibles = visible_count(data, y, x)

  return '#' if value == 'L' && visibles == 0
  return 'L' if value == '#' && visibles >= 5

  value
end

def process(data)
  state = ''

  loop do
    data = data.map.with_index do |ys, y|
      ys.map.with_index { |v, x| next_value(data, y, x) }
    end

    next_state = data.flatten.join('-')

    break if state == next_state

    state = next_state
  end

  data.flatten.count('#')
end

def input
  File.readlines('./input.txt').map { |line| line.chomp.chars }
end

puts process(input)
