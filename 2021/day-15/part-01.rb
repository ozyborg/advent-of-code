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
  total(data, [0, 0], [data.size - 1, data.size - 1], {})
end

def input
  File.read(ARGV.first).split.map { |l| l.chomp.chars.map(&:to_i) }
end

puts process(input)
