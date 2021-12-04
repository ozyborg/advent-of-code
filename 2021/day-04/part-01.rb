def process(data)
  rows = data[:boards].flatten(1).map.with_index { |v, i| [v, i / 5] }.to_h
  columns = data[:boards].map(&:transpose).flatten(1).map.with_index { |v, i| [v, i / 5] }.to_h

  data[:numbers].size.times do |i|
    subset = data[:numbers].first(i)

    row = rows.find { |r, v| (r - subset).empty? }&.last
    column = columns.find { |c, v| (c - subset).empty? }&.last

    winner = row || column

    break (data[:boards][winner].flatten - subset).sum * subset.last if winner
  end
end

def input
  numbers, *boards = File.read(ARGV.first).split("\n\n")

  {
    numbers: numbers.split(',').map(&:to_i),
    boards: boards.map do |b|
      b.split("\n").map { |l| l.split(' ').map(&:to_i) }
    end
  }
end

puts process(input)
