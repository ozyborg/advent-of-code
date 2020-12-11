def adjacents(data, y, x)
  n = y - 1 < 0 ? data.size : y - 1
  s = y + 1
  w = x - 1 < 0 ? data.first.size : x - 1
  e = x + 1

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

def next_value(data, y, x)
  value = data.dig(y, x)
  adjs = adjacents(data, y, x)

  return '#' if value == 'L' && adjs.none?('#')
  return 'L' if value == '#' && adjs.count('#') >= 4

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
