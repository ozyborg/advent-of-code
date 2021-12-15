def total(data, source, dest, history)
  pos_r = [source.first, source.last + 1]
  pos_b = [source.first + 1, source.last]

  totals = []

  if pos_r.last < data.size
    history[pos_r] ||= total(data, pos_r, dest, history)
    totals << data.dig(*pos_r) + history[pos_r]
  end

  if pos_b.first < data.size
    history[pos_b] ||= total(data, pos_b, dest, history)
    totals << data.dig(*pos_b) + history[pos_b]
  end

  totals.min || 0
end

def process(data)
  data = data * 5
  data = data.map { |d| d * 5 }

  data.size.times do |x|
    data.size.times do |y|
      data[x][y] += (x / (data.size / 5) + y / (data.size / 5))
      data[x][y] = data[x][y] - 9 if data[x][y] > 9
    end
  end

  total(data, [0, 0], [data.size - 1, data.size - 1], {})
end

def input
  File.read(ARGV.first).split.map { |l| l.chomp.chars.map(&:to_i) }
end

puts process(input)
