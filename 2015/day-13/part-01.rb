def process(data)
  index = data.map(&:first).uniq.map { |d| [d, {}] }.to_h

  data.each { |d| index[d.first][d.last] = d[1] == 'gain' ? d[2].to_i : d[2].to_i * -1 }

  index.keys.permutation.map do |p|
    (p + [p.first]).each_cons(2).sum { |c| index[c.first][c.last] + index[c.last][c.first] }
  end.max
end

def input
  File.read(ARGV.first).scan(/(\w+) would (\w+) (\w+) happiness units by sitting next to (\w+).\n/)
end

puts process(input)

