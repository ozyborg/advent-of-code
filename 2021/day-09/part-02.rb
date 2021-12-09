def count(x, y, data, history)
  [[x - 1, y], [x + 1, y], [x, y - 1], [x, y + 1]].sum do |adj|
    v = data.dig(*adj)

    next 0 if adj.include?(-1) || v.nil? || v == 9 || history[adj]

    history[adj] = true

    1 + count(*adj, data, history)
  end
end

def process(data)
  lows = data.flat_map.with_index do |row, x|
    row.filter_map.with_index do |r, y|
      adjs = [[x - 1, y], [x + 1, y], [x, y - 1], [x, y + 1]]
      [x, y] if adjs.map { |xy| data.dig(*xy) }.compact.min > r
    end
  end

  lows.map { |x, y| count(x, y, data, {}) }.sort.last(3).reduce(:*)
end

def input
  File.readlines(ARGV.first).map { |l| l.chomp.chars.map(&:to_i) }
end

puts process(input)
